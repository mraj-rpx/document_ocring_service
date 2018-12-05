# coding: utf-8

import sys
from IPython import embed
import unittest

sys.path.insert(0, '..')

import rejection_parser

def del_rej_sent(dic):
    del(dic['rejection_sentence'])

class RejectionParserTest(unittest.TestCase):
    def test_rejection_basic_details(self):
        with open('../../py_tests/ctnf_files/09271617-2003-09-03-00005-CTNF.txt') as f:
            text = f.read()
        data = rejection_parser.get_rej_details(text)
        embed()

if __name__ == '__main__':
    unittest.main()
