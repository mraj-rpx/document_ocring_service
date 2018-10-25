import concurrent.futures
import uuid
import requests
import json
import csv
import os

MAX_THREAD_POOL = 2
TOTAL_RECORDS = 10133179

"""
curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'criteria=*%3A*&start=0&rows=100' 'https://developer.uspto.gov/ds-api/oa_rejections/v1/records'

"""

class RejectionBackfill:
    def __init__(self, offset, limit):
        self.url = 'https://developer.uspto.gov/ds-api/oa_rejections/v1/records'
        self.headers = {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json'
        }
        self.offset = offset
        self.limit = limit
        self.parameters = {
            'version': 'v1',
            'dataset': 'oa_rejections',
            'criteria': '*:*',
            'start': self.offset,
            'rows': self.limit
        }

    def fetch_data(self):
        try:
            response = requests.post(self.url, data=self.parameters, headers=self.headers)
            try:
                data_json = json.loads(response.content)['response']['docs']
                data_csv = list(map(self.format_json_data, data_json))
            except Exception as exec:
                response = None
        except Exception as exec:
            response = None

        ret_status= {}
        if response == None:
            ret_status = {'status': 'error', 'params': {'offset': self.offset, 'limit': self.limit}}
        else:
            ret_status = {'status': 'success', 'json': response.content, 'csv': data_csv}
        return ret_status

    def format_json_data(self, data):
        return list(map((lambda x: ''.join(x)), data.values()))

def rejection_backfill(params):
    backfill = RejectionBackfill(params['offset'], params['limit'])
    return backfill.fetch_data()

def start_process():
    start_offset = 1
    limit = 100

    while start_offset <= TOTAL_RECORDS:
        params = []
        for i in range(1, 11):
            if start_offset <= TOTAL_RECORDS:
                offset = start_offset
                params.append({'offset': offset, 'limit': limit})
                start_offset = offset + limit

        failures = []
        data_json = []
        data_csv = []

        with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_THREAD_POOL) as executor:
            futures_to_rejection_backfill = [executor.submit(rejection_backfill, param) for param in params]
            for future in concurrent.futures.as_completed(futures_to_rejection_backfill):
                ret_status = future.result()
                if ret_status['status'] == 'error':
                    failures.append(ret_status['params'])
                else:
                    data_json.append(json.loads(ret_status['json']))
                    data_csv = data_csv + ret_status['csv']

        dir_name = "{0}/{1}-{2}".format(os.getcwd(), params[0]['offset'], params[-1]['offset'] + limit - 1)
        os.mkdir(dir_name)

        if data_json:
            with open("{0}/content.json".format(dir_name), 'w+') as json_file:
                json_file.write(json.dumps(data_json))
            with open("{0}/content.csv".format(dir_name), 'w+') as csv_file:
                spamwriter = csv.writer(csv_file, quotechar='"', quoting=csv.QUOTE_MINIMAL)
                spamwriter.writerows(data_csv)
        if failures:
            with open("{0}/failures.jaon".format(dir_name), 'w+') as json_file:
                json_file.write(json.dumps(failures))
        print("Completed")

start_process()
