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
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'BAYARDO et al.'
        },{
            'claim_nums': [7, 8, 9, 10, 18, 19, 20, 21, 25, 26, 27, 28],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'BAYARDO et at'
        }]
        self.assertEqual(data, result)

    # DATA: One reference name and app num
    def test_one_ref_and_app_num(self):
        with open('../py_tests/ctnf_files/09548237-2003-01-28-00001-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 3, 14],
                'rejection_ground': '112'
            },
            {
                'claim_nums': [1, 2, 7, 8, 9, 10],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Lara D. Catledge et al.'
            },
            {
                'claim_nums': [3, 4, 5, 6, 11, 12],
                'rejection_ground': '102(a)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Lara D. Catledge et al.'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num
    def test_one_ref_and_app_num_1(self):
        with open('../py_tests/ctnf_files/09632466-2002-11-27-00003-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 2, 3, 4, 5, 7, 8, 9, 10],
                'rejection_ground': '102(e)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Garney et at.',
                'ref_doc_num': 'US Patent 5,890,015'
            },
            {
                'claim_nums': [6, 11],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Garney et al.',
                'ref_doc_num': 'US Patent 5,890,015'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num with pub no.
    def test_one_ref_and_app_num_with_pub_no(self):
        with open('../py_tests/ctnf_files/09632466-2003-05-07-00002-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 10],
                'rejection_ground': '102(e)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Mizutan et al.',
                'ref_doc_num': 'Pub No. :US 2003/0043771 A1'
            },
            {
                'claim_nums': [2, 3, 4, 5, 6, 7, 8, 9, 11],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Mizutani et al.',
                'ref_doc_num': 'Pub. No.: US 2003/0043771 A1'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num and in view ref name and ref app num
    def test_one_ref_and_app_num_with_in_view_ref_name_and_ap_num(self):
        with open('../py_tests/ctnf_files/09933493-2004-10-21-00006-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Purcell',
                'ref_doc_num': 'US 2001/0013038 A1',
                'in_view_ref_name': 'Hughes et al.',
                'in_view_ref_doc_num': 'US 2003/0195876 A1_'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num with hereinafter for app num
    def test_one_ref_and_app_num_with_hereinafter_for_app_num(self):
        with open('../py_tests/ctnf_files/09933493-2006-03-09-00004-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 20, 21, 24, 25, 26, 27, 29, 30, 31, 32, 33],
                'rejection_ground': '102(b)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Zimowski et ai.',
                'ref_doc_num': 'US Patent 5,632,015'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num with in view ref name
    def test_one_ref_and_app_num_with_in_view_refs(self):
        with open('../py_tests/ctnf_files/09933493-2006-12-04-00004-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Zimowski et al.',
                'ref_doc_num': 'US Pateht 5,632,015',
                'in_view_ref_name': 'Spaey et al.',
                'in_view_ref_doc_num': 'US Patent Publication 2002/0055981 A1'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num 2
    def test_one_ref_and_app_num_2(self):
        with open('../py_tests/ctnf_files/09933493-2008-02-20-00004-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [52, 53],
                'rejection_ground': '102(e)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Yano  et al,',
                'ref_doc_num': 'US Patent Publication 2006/0184546 A1'
            }
        ]
        self.assertEqual(data, result)

    # DATA: One reference name and app num 2
    def test_one_ref_and_app_num_3(self):
        with open('../py_tests/ctnf_files/09933493-2008-11-13-00004-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        list(map(del_rej_sent, data))
        result = [
            {
                'claim_nums': [52, 53],
                'rejection_ground': '102(e)',
                'rejection_reason': 'anticipated',
                'ref_name': 'Yano  et al.',
                'ref_doc_num': 'US Patent Publication 2006/0184546 A1'
            },
            {
                'claim_nums': [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,54,55,56,57,58,59,60],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Yano et al.',
                'ref_doc_num': 'US Patent Publication 2006/0184546   A1',
                'in_view_ref_name': 'Hailpern et al.',
                'in_view_ref_doc_num': 'US Patent 7,383,299 Bi',
                'in_further_view_ref_name': 'Chua et al.',
                'in_further_view_ref_doc_num': 'US Patent Publication 2002/0049756 A1'
            },
            {
                'claim_nums': [24, 25, 26, 27, 63, 64],
                'rejection_ground': '103(a)',
                'rejection_reason': 'unpatentable',
                'ref_name': 'Yano et al.',
                'ref_doc_num': 'US Patent Publication 2006/0184546 A1',
                'in_view_ref_name': 'Hailpern et al.',
                'in_view_ref_doc_num': 'US Patent 7,383,299 B1',
                'in_further_view_ref_name': 'Chua et al.',
                'in_further_view_ref_doc_num': 'US Patent Publication 2002/0049756 A1',
                'and_in_further_view_ref_name': 'Vora et. al',
                'and_in_further_view_ref_doc_num': 'US Patent 6,539,379 B1'
            }
        ]
        self.assertEqual(data, result)

if __name__ == '__main__':
    unittest.main()
