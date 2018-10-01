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
        self.dataset = []

    def execute_cmd(self, cmd):
        _, _ = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()

    def parse_files(self, files, file_type):
        print("Started parsing files {0}, of type {1}".format(files, file_type))

        for fl in files:
            with open("{0}/{1}".format(self.ocr_unzip_dir, fl)) as f:
                file_content = f.read()
                data = frp.parse(file_content)
                rejection_date_dict = frp.parse_rej_date(fl)
                for dd in data:
                    dd.update(rejection_date_dict)
                    dd['rejection_type'] = file_type
                    dd['pair_ocr_id'] = self.pair_id
                self.dataset = self.dataset + data

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

def start_process():
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS,host=DB_HOST)
    cur = conn.cursor()
    sql_select = """
    SELECT id, ocr_s3_path, app_data_id FROM pair.pair_ocr WHERE needs_ocr = %s AND ocr_s3_path IS NOT NULL ORDER BY id ASC LIMIT 100;
    """
    """
    INSERT INTO document_ocr_service.app_data_rejections (claim_nums, rejection_ground, rejection_reason, ref_name, ref_doc_num, in_view_ref_name, in_view_ref_doc_num, in_further_view_ref_name, in_further_view_ref_doc_num, app_num, rejection_date, rejection_type, pair_ocr_id) VALUES %s
    """
    insert_sql = "INSERT INTO document_ocr_service.app_data_rejections (claim_nums, rejection_ground, rejection_reason, ref_name, ref_doc_num, in_view_ref_name, in_view_ref_doc_num, in_further_view_ref_name, in_further_view_ref_doc_num, app_num, rejection_date, rejection_type, pair_ocr_id) VALUES %s;"
    cur.execute(sql_select, (False,))
    tuple_vals = cur.fetchall()
    print("Fetched tuples: {0}".format(tuple_vals))

    for tup in tuple_vals:
        frp_proc = FrpProcess(tup)
        rej_data = frp_proc.process()
        tup_coll = []
        for dd in rej_data:
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
                'app_num': None,
                'rejection_date': None,
                'rejection_type': None,
                'pair_ocr_id': None
            }
            a_record.update(dd)
            values = tuple(a_record.values())
            tup_coll.append(values)
        if tup_coll:
            print("DATASET:\n {0}".format(tup_coll))
            pg_extras.execute_values(cur, insert_sql, tup_coll, template=None, page_size=100)
            conn.commit()


if __name__ == '__main__':
    start_process()
