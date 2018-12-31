import tesserocr
import io
import concurrent.futures
import time
import psycopg2
import uuid
import os
import subprocess
import shutil
from PIL import Image
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from io import StringIO
import configparser

config = configparser.ConfigParser()
config.read('app_data_ocr_config.ini')

MAX_PROCESS_POOL = int(config['DEFAULT']['MAX_PROCESS_POOL'])
PDF_MAX_POOL = MAX_PROCESS_POOL * 2
PAGE_MAX_POOL = MAX_PROCESS_POOL * 2
RECORD_LIMIT = config['DEFAULT']['RECORD_LIMIT']
RECORD_OFFSET = config['DEFAULT']['RECORD_OFFSET']

DB_NAME = config['DEFAULT']['DB_NAME']
DB_HOST = config['DEFAULT']['DB_HOST']
DB_USER = config['DEFAULT']['DB_USER']
DB_PASS = config['DEFAULT']['DB_PASS']

IMG_WRAPPER_DIR_NOT_EXIST_STATUS = 1
NO_NEW_FILES_STATUS = 2
UNKNOWN_ERROR_STATUS = 3
OCR_HOST = os.uname()[1]

class ImageFileWrapperDirNotExistException(Exception):
    def __init__(self, message):
        super().__init__(message)
        self.message = message

class OcrAPdf:
    def __init__(self, zip_dir, pdf_unzip_dir, ocr_unzip_dir, filename):
        self.zip_dir = zip_dir
        self.pdf_unzip_dir = pdf_unzip_dir
        self.ocr_unzip_dir = ocr_unzip_dir
        self.filename = filename

    def extract_text_from_paint_pdf(self, pdf_filename):
        rsrcmgr = PDFResourceManager()
        retstr = StringIO()
        codec = 'utf-8'
        laparams = LAParams()
        device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
        fp = open(pdf_filename, 'rb')
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        password = ""
        maxpages = 0
        caching = True
        pagenos = set()

        try:
            for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
                interpreter.process_page(page)
        except:
            print("Could not able to extract TEX from PDF using PDFMINER.")
            pass
        fp.close()
        device.close()
        str = retstr.getvalue()
        retstr.close()
        return str

    def extract_text_from_scanned_pdf(self, pdf_filename):
        img_path = self.zip_dir + "/" + uuid.uuid4().hex
        os.mkdir(img_path)

        opts = "-despeckle +adjoin -limit memory 256Mib -limit map 512Mib -density 300 -colorspace GRAY"
        cmd = "gm convert {0} '{1}' {2}/%04d.jpg 2> /dev/null;".format(opts, pdf_filename, img_path)
        _, _ = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()
        jpg_files = os.listdir(img_path)
        img_files = {int(f_name.replace(".jpg", "")): "{0}/{1}".format(img_path, f_name) for f_name in jpg_files}
        ocr_texts = {}

        with concurrent.futures.ThreadPoolExecutor(max_workers=PAGE_MAX_POOL) as page_pool:
            for idx, ocr_text in zip(list(img_files.keys()), page_pool.map(tesserocr.file_to_text, list(img_files.values()))):
                ocr_texts[idx] = ocr_text

        sorted_tup = sorted(ocr_texts.items(), key=lambda kv: kv[0])
        sorted_ocr_texts = list(dict(sorted_tup).values())
        ocr_text = "\n".join(map(str, sorted_ocr_texts))
        shutil.rmtree(img_path)
        return ocr_text

    def process(self):
        pdf_filename = self.pdf_unzip_dir + "/" + self.filename + ".pdf"
        txt_filename = self.ocr_unzip_dir + "/" + self.filename + ".txt"
        """
        Extract the TEXT from PDF using PDFMINER when the PDF is a PLAIN PDF
        """
        pdf_text = self.extract_text_from_paint_pdf(pdf_filename)
        if not pdf_text.replace("\x0c", ""):
            pdf_text = self.extract_text_from_scanned_pdf(pdf_filename)

        with open(txt_filename, "wb") as file:
            file.write(pdf_text.encode())
        return txt_filename

class OcrProcess:
    def __init__(self, tuple_val):
        self.pair_ocr_id = tuple_val[0]
        self.pdf_zip = tuple_val[1]
        self.ocr_zip = tuple_val[2]
        self.app_data_id = tuple_val[3]
        if self.ocr_zip == '100':
            self.ocr_zip = None
        self.zip_dir = os.getcwd() + "/" + uuid.uuid4().hex

        self.pdf_zip_name = self.pdf_zip.split("/")[-1]
        self.actual_dir_name = self.pdf_zip_name.replace(".zip", "")
        self.ocr_zip_name = "image_file_wrapper_ocr.zip"
        self.pdf_zip_file = self.zip_dir + "/" + self.pdf_zip_name
        self.ocr_zip_file = self.zip_dir + "/" + self.ocr_zip_name

        self.pdf_unzip_dir = self.zip_dir + "/" + self.actual_dir_name + "/" + self.actual_dir_name + "-image_file_wrapper"
        self.ocr_unzip_dir = self.zip_dir + "/" + "image_file_wrapper_ocr"

    def execute_cmd(self, cmd):
    	_, _ = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()

    def ocrable_pdfs(self):
        os.mkdir(self.zip_dir)

        self.execute_cmd("aws s3 cp --profile default s3://{0} {1}/".format(self.pdf_zip, self.zip_dir))
        self.execute_cmd("unzip {0} -d {1}".format(self.pdf_zip_file, self.zip_dir))

        if self.ocr_zip:
            self.execute_cmd("aws s3 cp --profile default s3://{0} {1}/".format(self.ocr_zip, self.zip_dir))
            self.execute_cmd("unzip {0} -d {1}".format(self.ocr_zip_file, self.zip_dir))
        else:
            os.mkdir(self.ocr_unzip_dir)

        ocr_files = set(map((lambda x: x.replace(".txt", "")), os.listdir(self.ocr_unzip_dir)))
        if os.path.isdir(self.pdf_unzip_dir) == False:
            raise ImageFileWrapperDirNotExistException("Image file wrapper directory does not exist.")

        ctnf_ctfr_files = list(filter((lambda x: x.endswith("CTNF.pdf") or x.endswith("CTFR.pdf")), os.listdir(self.pdf_unzip_dir)))
        pdf_files = set(map((lambda x: x.replace(".pdf", "")), ctnf_ctfr_files))
        return list(pdf_files.difference(ocr_files))

    def start_ocr_a_pdf(self, pdf):
        ocr_status = {"status": "SUCCESS"}

        try:
            txt_file = OcrAPdf(self.zip_dir, self.pdf_unzip_dir, self.ocr_unzip_dir, pdf).process()
            ocr_status["txt_file"] = txt_file
        except:
            ocr_status["status"] = "FAILED"
        return ocr_status

    def ocr(self):
        try:
            new_files = self.ocrable_pdfs()

            if not new_files:
                shutil.rmtree(self.zip_dir)
                return NO_NEW_FILES_STATUS

            pdf_txt_dict = {}
            needs_ocr = False
            needs_parsing = True

            with concurrent.futures.ThreadPoolExecutor(max_workers=PDF_MAX_POOL) as pdf_pool:
                for pdf_file, ocr_status in zip(new_files, pdf_pool.map(self.start_ocr_a_pdf, new_files)):
                    if ocr_status["status"] == "SUCCESS":
                        pdf_txt_dict[pdf_file] = ocr_status["txt_file"]
                    else:
                        needs_ocr = True
                        needs_parsing = False

            if os.path.exists(self.ocr_zip_file):
                os.remove(self.ocr_zip_file)
            self.execute_cmd("cd {0}; zip -r {1} {2}".format(self.zip_dir, self.ocr_zip_name, self.ocr_zip_name.replace(".zip", "")))
            self.execute_cmd("aws s3 cp --profile default {0} s3://rpx-public-pair/{1}/".format(self.ocr_zip_file, self.actual_dir_name))
            shutil.rmtree(self.zip_dir)
            ocred_files = list(map(lambda x: "{0}.pdf".format(x), pdf_txt_dict.keys()))
            ocr_s3_path = "rpx-public-pair/{0}/{1}".format(self.actual_dir_name, self.ocr_zip_name)
            return {'ocred_files': ocred_files, 'ocr_s3_path': ocr_s3_path, "needs_ocr": needs_ocr, "needs_parsing": needs_parsing}
        except ImageFileWrapperDirNotExistException as img_wrap_dir_not_exist:
            shutil.rmtree(self.zip_dir)
            return IMG_WRAPPER_DIR_NOT_EXIST_STATUS
        except Exception as exeception:
            shutil.rmtree(self.zip_dir)
            return UNKNOWN_ERROR_STATUS

if __name__ == '__main__':
    def worker_start_ocr(tup):
        ocr_process = OcrProcess(tup)
        ocr_status = ocr_process.ocr()

        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS,host=DB_HOST)
        cur = conn.cursor()

        sql_update = "UPDATE pair.pair_ocr SET ocr_s3_path = %s, needs_ocr = %s, needs_parsing = %s, ocred_by = %s, ocred_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP WHERE id = %s"
        img_sql_update = "UPDATE pair.image_file_wrapper SET is_ocred = %s, updated_at = CURRENT_TIMESTAMP WHERE app_data_id = %s AND file_name IN %s"
        needs_ocr_update_sql = "UPDATE pair.pair_ocr SET needs_ocr = %s, updated_at = CURRENT_TIMESTAMP WHERE id = %s"

        if ocr_status:
            if ocr_status == IMG_WRAPPER_DIR_NOT_EXIST_STATUS:
                print("IMG FILE wrapper dir does not exist for PAIR ID: '{0}'".format(ocr_process.pair_ocr_id))
                cur.execute(needs_ocr_update_sql, (True, ocr_process.pair_ocr_id))
                conn.commit()
            elif ocr_status == UNKNOWN_ERROR_STATUS:
                print("Unknown error for PAIR ID: '{0}'".format(ocr_process.pair_ocr_id))
                cur.execute(needs_ocr_update_sql, (True, ocr_process.pair_ocr_id))
                conn.commit()
            elif ocr_status == NO_NEW_FILES_STATUS:
                print("No new files available for OCR, for PAIR ID: '{0}'".format(ocr_process.pair_ocr_id))
                cur.execute(needs_ocr_update_sql, (False, ocr_process.pair_ocr_id))
                conn.commit()
            else:
                ocr_s3_path = ocr_status['ocr_s3_path']
                ocred_files = tuple(ocr_status['ocred_files'])
                needs_ocr = ocr_status["needs_ocr"]
                needs_parsing = ocr_status["needs_parsing"]

                cur.execute(sql_update, (ocr_s3_path, needs_ocr, needs_parsing, OCR_HOST, ocr_process.pair_ocr_id))
                cur.execute(img_sql_update, (True, ocr_process.app_data_id, ocred_files))
                conn.commit()
                print("Completed OCR for PAIR_ID: {0}".format(ocr_process.pair_ocr_id))
        else:
            print("Could not OCR the PAIR: '{0}'".format(tup))

        conn.close()
        return ocr_process

    def start_ocr():
        sql_select = """
        SELECT id, app_s3_path, ocr_s3_path, app_data_id FROM pair.pair_ocr
        WHERE needs_ocr = %s AND ocr_priority = %s
        ORDER BY id ASC LIMIT %s OFFSET %s;
        """
        sql_update_processing = "UPDATE pair.pair_ocr SET needs_ocr = %s WHERE id IN %s"
        ifw_query = "SELECT app_data_id, COUNT(*) FROM pair.image_file_wrapper WHERE app_data_id IN %s AND is_ocred != 't' AND doc_code IN %s GROUP BY app_data_id"

        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS,host=DB_HOST)
        cur = conn.cursor()
        cur.execute(sql_select, (True, 100, RECORD_LIMIT, RECORD_OFFSET,))
        tuple_vals = cur.fetchall()

        print("Fetched tuples: {0}".format(tuple_vals))

        if not tuple_vals:
            print("No records to process")
            return

        pair_ids = [[tup[0], tup[3]] for tup in tuple_vals]
        p_ids = [tup[0] for tup in tuple_vals]
        cur.execute(sql_update_processing, (None, tuple(p_ids)))
        conn.commit()


        # See if there's any file to OCR in pair.image_file_wrapper table
        ifw_ocr_status = {}
        ocrable_apps = []
        remaining_apps = []

        app_data_ids = [pair_id[1] for pair_id in pair_ids]
        cur.execute(ifw_query, (tuple(app_data_ids), ('CTNF', 'CTFR')))
        ifw_records = cur.fetchall()

        for ifw_record in ifw_records:
            ifw_ocr_status[ifw_record[0]] = ifw_record[1]

        for tuple_val in tuple_vals:
            ifw_count = ifw_ocr_status[tuple_val[3]]
            if ifw_count > 0:
                ocrable_apps.append(tuple_val)
            else:
                remaining_apps.append(tuple_val)

        p_ids = [tup[0] for tup in remaining_apps]
        cur.execute(sql_update_processing, (False, tuple(p_ids)))

        conn.commit()
        conn.close()

        try:
            with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_PROCESS_POOL) as process_pool:
                for pair_id, ocr_process in zip(pair_ids, process_pool.map(worker_start_ocr, ocrable_apps)):
                    pass
        except Exception as e:
            print("There's an exception while processing PROCESS POOL EXECUTOR and the exception is: '{0}'".format(e))
            conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS,host=DB_HOST)
            cur = conn.cursor()
            cur.execute(sql_update_processing, (True, tuple(p_ids)))
            conn.commit()
            conn.close()

    cont = True
    while cont:
        print(time.ctime())
        start_ocr()
        print("Completed a round and proceeding next...")
        print(time.ctime())
        subprocess.Popen('rm -rf /tmp/gm*', stdout=subprocess.PIPE, shell=True).communicate()
        time.sleep(5)
