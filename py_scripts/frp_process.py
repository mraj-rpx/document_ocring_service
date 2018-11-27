import os
import psycopg2
import uuid
import subprocess
import shutil
from psycopg2 import extras as pg_extras

import frp
from IPython import embed

DB_NAME = 'rpx'
DB_HOST = 'dev-coredb'
DB_USER = 'document_ocr_service'
DB_PASS = 'document_ocr_service-dev'

class FrpProcess:
    def __init__(self, tup):
        self.tup = tup
        self.ocr_s3_path = tup[1]
        self.pair_id = tup[0]
        self.zip_dir = "{0}/{1}".format(os.getcwd(), uuid.uuid4().hex)
        self.zip_name = self.ocr_s3_path.split('/')[-1]
        self.app_num = self.ocr_s3_path.split('/')[-2]
        self.ocr_zip_file = "{0}/{1}".format(self.zip_dir, self.zip_name)
        self.dataset = {}

    def execute_cmd(self, cmd):
        _, _ = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()

    def parse_files(self, files, file_type):
        print("Started parsing files {0}, of type {1}".format(files, file_type))

        for fl in files:
            with open("{0}/{1}".format(self.ocr_unzip_dir, fl)) as f:
                file_content = f.read()
                data = frp.parse(file_content)

                office_action_dict = frp.parse_rej_date(fl)
                office_action_dict.update({'rejection_type': file_type, 'pair_ocr_id': self.pair_id})

                if not fl in self.dataset:
                    self.dataset[fl] = {'office_action': office_action_dict, 'rejections': {}}
                oa_dataset = self.dataset[fl]['rejections']

                for dd in data:
                    a_record = {
                        'claim_nums': None,
                        'rejection_ground': None,
                        'rejection_reason': None,
                        'ref_name': None,
                        'ref_doc_num': None,
                        'in_view_ref_name': None,
                        'in_view_ref_doc_num': None,
                        'in_further_view_ref_name': None,
                        'in_further_view_ref_doc_num': None,
                        'rejection_sentence': None
                    }
                    a_record.update(dd)

                    dataset_key = "{0}-{1}-{2}".format('$$$'.join(map(str, a_record['claim_nums'])), a_record['rejection_ground'], a_record['rejection_reason'])
                    if not dataset_key in oa_dataset:
                        oa_dataset[dataset_key] = {
                            'rejection': {
                                'claim_nums': a_record['claim_nums'],
                                'rejection_ground': a_record['rejection_ground'],
                                'rejection_reason': a_record['rejection_reason'],
                                'rejection_sentence': a_record['rejection_sentence']
                            },
                            'citations': []
                        }
                    rej_dict = oa_dataset[dataset_key]['rejection']
                    cits_list = oa_dataset[dataset_key]['citations']

                    for idx, ref in enumerate(['', 'in_view', 'in_further_view']):
                        if ref:
                            ref_name_k = "_".join([ref, 'ref_name'])
                            ref_doc_num_k = "_".join([ref, 'ref_doc_num'])
                        else:
                            ref_name_k = 'ref_name'
                            ref_doc_num_k = 'ref_doc_num'

                        if a_record[ref_name_k] or a_record[ref_doc_num_k]:
                            cit_dict = {
                                'ref_name': a_record[ref_name_k],
                                'ref_app_num': a_record[ref_doc_num_k],
                                'ref_flag': idx + 1
                            }
                            if not cit_dict in cits_list:
                                cits_list.append(cit_dict)

    def process(self):
        os.mkdir(self.zip_dir)
        self.execute_cmd("aws s3 cp --profile default s3://{0} {1}/".format(self.ocr_s3_path, self.zip_dir))
        self.execute_cmd("unzip {0} -d {1}".format(self.ocr_zip_file, self.zip_dir))

        legacy_unzip_dir = "{0}/{1}".format(self.zip_dir, "{0}-ocr".format(self.app_num))

        if os.path.isdir(legacy_unzip_dir):
            self.ocr_unzip_dir = legacy_unzip_dir
        else:
            self.ocr_unzip_dir = "{0}/image_file_wrapper_ocr".format(self.zip_dir)

        all_files = os.listdir(self.ocr_unzip_dir)

        ctnf_files = list(filter((lambda x: x.endswith('CTNF.txt')), all_files))
        ctfr_files = list(filter((lambda x: x.endswith('CTFR.txt')), all_files))

        self.parse_files(ctnf_files, 'CTNF')
        self.parse_files(ctfr_files, 'CTFR')
        shutil.rmtree(self.zip_dir)
        return self.dataset

if __name__ == '__main__':
    def start_process():
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS,host=DB_HOST)
        cur = conn.cursor()
        sql_select = """
        SELECT id, ocr_s3_path, app_data_id FROM pair.pair_ocr WHERE needs_ocr = %s AND ocr_s3_path IS NOT NULL ORDER BY id ASC LIMIT 100;
        """

        insert_oa_sql = """
        INSERT INTO app_office_actions (app_num, mailing_date, rejection_type, rejection_sentence, pair_ocr_id) values (%s, %s, %s, %s) RETURNING id;
        """
        insert_rej_sql = """
        INSERT INTO app_rejections (claim_nums, rejection_ground, rejection_reason, app_office_action_id) VALUES (%s, %s, %s, %s) RETURNING id;
        """
        insert_cit_sql = """
        INSERT INTO app_citations (ref_name, ref_app_num, ref_flag, app_rejection_id) values %s;
        """

        cur.execute(sql_select, (False,))
        tuple_vals = cur.fetchall()
        print("Fetched tuples: {0}".format(tuple_vals))

        for tup in tuple_vals:
            frp_proc = FrpProcess(tup)
            rej_data = frp_proc.process()
            cits_list = []
            for fname, dd in rej_data.items():
                oa_values = list(dd['office_action'].values())
                cur.execute(insert_oa_sql, tuple(oa_values))
                oa_id = cur.fetchone()[0]
                for regkey, rej in dd['rejections'].items():
                    rejn = list(rej['rejection'].values())
                    rejn.append(oa_id)
                    cur.execute(insert_rej_sql, tuple(rejn))
                    rej_id = cur.fetchone()[0]
                    for cit in rej['citations']:
                        cit_tup = list(cit.values())
                        cit_tup.append(rej_id)
                        cits_list.append(tuple(cit_tup))

            pg_extras.execute_values(cur, insert_cit_sql, cits_list, template=None, page_size=100)
            conn.commit()
        conn.close()

    cont = True
    while cont:
        print(time.ctime())
        start_process()
        print("Completed a round and proceeding next...")
        print(time.ctime())
        time.sleep(5)
