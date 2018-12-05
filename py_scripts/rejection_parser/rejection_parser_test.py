# coding: utf-8

import sys
from IPython import embed
import unittest

sys.path.insert(0, '..')

import rejection_parser

def del_rej_sent(dic):
    del(dic['rejection_sentence'])

class RejectionParserTest(unittest.TestCase):
    # DATA: Only reference name
    def test_only_one_ref_name(self):
        with open('../py_tests/ctnf_files/09271617-2003-09-03-00005-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [{
            'claim_nums': [1, 3, 5, 6, 15, 16, 17, 39, 40],
            'rejection_ground': '35 U.S.C. 102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'BAYARDO et al.'
        },{
            'claim_nums': [7, 8, 9, 10, 18, 19, 20, 21, 25, 26, 27, 28],
            'rejection_ground': '35 U.S.C. 103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'BAYARDO et at'
        }]
        self.assertEqual(data, result)

    # DATA: One reference name and app num
    def test_one_ref_and_app_num(self):
        with open('../py_tests/ctnf_files/09548237-2003-01-28-00001-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        embed()
        list(map(del_rej_sent, data))
        result = []
        self.assertEqual(data, result)

if __name__ == '__main__':
    unittest.main()
