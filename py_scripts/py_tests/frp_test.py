import sys
from IPython import embed
import unittest

sys.path.insert(0, '..')

import frp

class FrpTest(unittest.TestCase):
    """
    Should capture the details from the straight forward input string
    """
    def test_fr_from_straight_ip_text(self):
        text = "Claims 50-51 are rejected under 35 U.S.C. 102(e) as being anticipated by Huang (6,362,748)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [50, 51],
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Huang',
            'ref_doc_num': '6,362,748'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN VIEW REF DETAILS
    """
    def test_fr_from_in_view_ref(self):
        text = "Claims 2,4,5,11,14,17-19 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang (6,362,748) in view of Amro (6,292,747)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [2, 4, 5, 11, 14, 17, 18, 19],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'ref_doc_num': '6,362,748',
            'in_view_ref_name': 'Amro',
            'in_view_ref_doc_num': '6,292,747'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN FURTHER VIEW REF DETAILS
    """
    def test_fr_from_in_further_view_ref(self):
        text = "Claims 3,6,7,10,15 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in view of Knockeart (6,662,083)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [3, 6, 7, 10, 15],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_further_view_ref_name': 'Knockeart',
            'in_further_view_ref_doc_num': '6,662,083'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN FURTHER VIEW REF DETAILS with doc num is in the for mat of US 2001/12890 A1
    """
    def test_fr_from_in_further_view_ref_with_doc_num_US_NUM(self):
        text = "Claims 12-13 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in view of Newell (US 2001/0142759 A1)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [12, 13],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_further_view_ref_name': 'Newell',
            'in_further_view_ref_doc_num': 'US 2001/0142759 A1'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN VIEW REF DETAILS with multiple range claim numbers
    """
    def test_fr_from_in_view_with_multiple_range_claim_nums(self):
        text = "Claims 37-42, 46, 48-49 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski (7,257,426)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [37, 38, 39, 40, 41, 42, 46, 48, 49],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_view_ref_doc_num': '7,257,426'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN VIEW REF DETAILS with single claim
    """
    def test_fr_from_in_view_with_single_claim_nums(self):
        text = "Claim 43 is rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Comerford (7,024,363)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [43],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_further_view_ref_name': 'Comerford',
            'in_further_view_ref_doc_num': '7,024,363'
        }]
        self.assertEqual(data, result)

    """
    Should capture the IN VIEW REF DETAILS with single claim
    """
    def test_fr_from_in_view_with_diff_claim_and_same_in_view(self):
        text = "Claims 44-45 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Newell (US 2002/0142759 A1)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [44, 45],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_further_view_ref_name': 'Newell',
            'in_further_view_ref_doc_num': 'US 2002/0142759 A1'
        }]
        self.assertEqual(data, result)

    """
    Should capture the details for ANTICIPATED REJECTION REASON
    """
    def test_fr_for_anticipated_rej_reason(self):
        text = "Claim 1 is rejected under 35 U.S.C. 102(e) as being anticipated by Chen (US 2005/0240672 A1)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [1],
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Chen',
            'ref_doc_num': 'US 2005/0240672 A1'
        }]
        self.assertEqual(data, result)

    """
    Should capture the details when REF NAME has MULTIPLE WORDS
    """
    def test_fr_for_multiple_words_in_ref_name(self):
        text = "Claims 1,5,6,7,17,20,26,28,31-37 and 43-45 are rejected under 35 U.S.C. 102(b) as being anticipated by Barenwald et al (Patent No 5,782,371)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [1, 5, 6, 7, 17, 20, 26, 28, 31, 32, 33, 34, 35, 36, 37, 43, 44, 45],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Barenwald et al',
            'ref_doc_num': '5,782,371'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of "With ref_doc_num and without ref_doc_num"
    """
    def test_fr_for_ctnf_format_1(self):
        with open('ctnf_files/10913441-2006-03-09-00006-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': [148, 149, 150, 151]
        },
        {
            'claim_nums': [148],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Ogawa et al',
            'ref_doc_num': '5,437,894'
        },
        {
            'claim_nums': [149, 150, 151],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Ogawa et al'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of specified data in this TEST
    """
    def test_fr_for_ctnf_format_2(self):
        with open('ctnf_files/10913441-2007-09-27-00003-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': [138, 139, 140, 141, 151]
        },
        {
            'claim_nums': [138, 148],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Ogawa et al',
            'ref_doc_num': '5,437,894'
        },
        {
            'claim_nums': [139, 140, 141, 149, 150, 151],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Ogawa et al'

        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of ''
    """
    def test_fr_for_ctnf_format_3(self):
        with open('ctnf_files/12317727-2010-09-16-00007-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 44, 45]
        },
        {
            'claim_nums': [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 44, 45],
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Steensma et al',
            'ref_doc_num': 'US Pub. No. 2004/0135902'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of ON THE GROUND OF NONSATURATORY
    """
    def test_fr_for_ctnf_format_4(self):
        with open('ctnf_files/13673692-2013-11-06-00006-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': list(range(1, 44)),
            'rejection_ground': 'nonstatutory double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,332,203'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of ON THE GROUND OF NONSATURATORY
    """
    def test_fr_for_ctnf_format_TEST_FROM_XLS_1(self):
        text = 'Claim(s) 1,5,6,10,14,16,21,28,31-37 and 43-45 is/are rejected.'
        data = frp.parse(text)
        result = [{
            'claim_nums': [1, 5, 6, 10, 14, 16, 21, 28, 31, 32, 33, 34, 35, 36, 37, 43, 44, 45]
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of ON THE GROUND OF NONSATURATORY
    """
    def test_fr_for_ctnf_format_TEST_FROM_XLS_2(self):
        text = 'Claims 1,5,6,7,17,20,26,28,31-37 and 43-45 are rejected under 35 U.S.C. 102(b) as being anticipated by Barenwald et al (Patent No 5,782,371).'
        data = frp.parse(text)
        result = [{
            'claim_nums': [1, 5, 6, 7, 17, 20, 26, 28, 31, 32, 33, 34, 35, 36, 37, 43, 44, 45],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Barenwald et al',
            'ref_doc_num': '5,782,371'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTFR
    """
    def test_fr_for_ctnf_format_5(self):
        with open('ctfr_files/10913441-2006-10-17-00002-CTFR.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': [148, 149, 150, 151]
        },
        {
            'claim_nums': [148],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Ogawa et al',
            'ref_doc_num': '5,437,894'
        },
        {
            'claim_nums': [149, 150, 151],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Ogawa et  al as applied to claim 148 above, and lrther',
            'in_view_ref_name': 'the follOwing comments'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTFR
    """
    def test_fr_for_ctnf_format_6(self):
        text = "Claim 1, 5, 6, 10, 20, 32-34, 36, 37, 43 and 45 are rejected under 35 U.S.C. 102(b) as being anticipated by Baerenwald et al (Patent no. 5,782,371)."
        data = frp.parse(text)
        result = [{
            'claim_nums': [1,5,6,10,20,32,33,34,36,37,43,45],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Baerenwald et al',
            'ref_doc_num': '5,782,371'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTFR
    """
    def test_fr_for_ctnf_format_7(self):
        text = "Claims 1, 2, 5-7 and 9 are rejected under 35 U.S.C. 102(b) as being anticipated by Orikasa (US 20020119414 A1)."
        data = frp.parse(text)
        result = [{
            'claim_nums': [1,2,5,6,7,9],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Orikasa',
            'ref_doc_num': 'US 20020119414 A1'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTFR
    """
    def test_fr_for_ctnf_format_without_doc_kind_code(self):
        text = "Claims 1, 2, 5-13 and 16-19 are rejected under 35 U.S.C. 102(b) as being anticipated by Christoff et al (US 6071119)."
        data = frp.parse(text)
        result = [{
            'claim_nums': [1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 18, 19],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Christoff et al',
            'ref_doc_num': 'US 6071119'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTFR
    """
    def test_fr_for_ctnf_format_without_doc_kind_code_with_in_view_ref(self):
        text = "Claims 52-59 and 62 are rejected under 35 U.S.C. 102(b) as being unpatentable over Inoue et al. (US 5,553,347) in view of Bell et al. (US 6,018,886)."
        data = frp.parse(text)
        result = [{
            'claim_nums': [52, 53, 54, 55, 56, 57, 58, 59, 62],
            'rejection_ground': '102(b)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Inoue et al.',
            'ref_doc_num': '5,553,347',
            'in_view_ref_name': 'Bell et al.',
            'in_view_ref_doc_num': '6,018,886'
        }]
        self.assertEqual(data, result)

    """
    Should parse the 103 IN VIEW
    """
    def test_fr_for_103_in_view_1(self):
        with open('ctnf_files/13052759-2012-01-10-00008-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': list(range(1, 720))
        },
        {
            'claim_nums': [1, 3, 4, 5, 9, 10, 11, 12, 13, 14, 15],
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '7909603'
        },
        {
            'claim_nums': [19],
            'rejection_ground': '112'
        },
        {
            'claim_nums': [1, 2, 5, 6, 7, 9],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Orikasa',
            'ref_doc_num': 'US 20020119414 A1'
        },
        {
            'claim_nums': [1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 16, 17, 18, 19],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Christoff et al',
            'ref_doc_num': 'US 6071119'

        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Christof',
            'claim_nums': [3, 4, 14, 15]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Orikasa',
            'claim_nums': [3, 4, 6, 7]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Orikasa',
            'in_view_ref_name': 'Christof',
            'claim_nums': [6, 7, 8]
        }]
        self.assertEqual(data, result)

    """
    Should parse the CLEARLY ANTICIPATED
    """
    def test_fr_for_ctnf_format_with_clearly_anticipated(self):
        text = "Claims 14 is rejected under 35 U.S.C. 102(b) as being clearly anticipated by Song, et al. (Research progress of ZnO single crystals) Song, et al teaches a flux method for growing bulk zinc-oxide (ZnO) utilizing the Bridgman method."
        data = frp.parse(text)
        result = [{
            'claim_nums': [14],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Song, et al'
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF
    """
    def test_fr_for_ctnf_format_with_diff_doc_num(self):
        with open('ctnf_files/13566986-2012-11-01-00007-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,009,646',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,111,678',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '7,348,930',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '13/118,386',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '13/118,406',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '13/348,523',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '13/218,185',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': 'nonstatutory obviousness- type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '13/192,181',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Lastinger et al',
            'ref_doc_num': '7,349,701',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        },
        {
            'rejection_ground': '102(a)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Kitchener et al',
            'ref_doc_num': '6,870,515',
            'claim_nums': [1, 2, 3, 6, 7, 8, 9, 12, 13, 14]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Kitchener et al',
            'ref_doc_num': '6,870,515',
            'in_view_ref_name': 'Hou et al',
            'in_view_ref_doc_num': '7,415,288',
            'claim_nums': [4, 5, 10, 11, 15, 16]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Kitchener et al',
            'ref_doc_num': '6,870,515',
            'claim_nums': [4, 5, 10, 11, 15, 16]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Hou et al',
            'ref_doc_num': '7,415,288',
            'in_view_ref_name': 'Kitchener et al',
            'in_view_ref_doc_num': '6,870,515',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
        }]
        self.assertEqual(data, result)

    """
    Should failon next docnum
    """
    def test_fr_for_ctnf_should_failon_next_doc_num(self):
        text = "Claims 3,6,7 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang (6,662,081). Claims 3,6,7,10 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro (6,662,082). Claims 3,6,7,10,15 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in view of Knockeart (6,662,083)"
        data = frp.parse(text)
        result = [{
            'claim_nums': [3, 6, 7],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'ref_doc_num': '6,662,081'
        },
        {

            'claim_nums': [3, 6, 7, 10],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_view_ref_doc_num': '6,662,082'
        },
        {
            'claim_nums': [3, 6, 7, 10, 15],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_further_view_ref_name': 'Knockeart',
            'in_further_view_ref_doc_num': '6,662,083'
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_hereinafter_prepend_to_doc_num(self):
        with open('ctnf_files/09933493-2004-10-21-00006-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': list(range(1, 28)),
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Purcell',
            'ref_doc_num': 'US 2001/0013038 A1',
            'in_view_ref_name': 'Hughes et al.',
            'in_view_ref_doc_num': 'US 2003/0195876 A1'
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_hereinafter_prepend_to_doc_num_with_US_PATENT(self):
        with open('ctnf_files/09933493-2006-03-09-00004-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'claim_nums': [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,20,21,24,25,26,27,29,30,31,32, 33]
        },
        {
            'claim_nums': [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,20,21,24,25,26,27,29,30,31,32, 33],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Zimowski et ai.',
            'ref_doc_num': '5,632,015'
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text with IN_VIEW_REF
    """
    def test_fr_for_ctnf_format_with_hereinafter_prepend_to_doc_num_with_IN_VIEW_REF(self):
        with open('ctnf_files/09933493-2006-12-04-00004-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37]
        },
        {
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Zimowski et al.',
            'ref_doc_num': '5,632,015',
            'in_view_ref_name': 'Spaey et al.',
            'in_view_ref_doc_num': '2002/0055981 A1'
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with NEXT PAGE SPERATOR
    """
    def test_fr_for_ctnf_format_with_hereinafter_prepend_to_doc_num_with_NEXT_PAGE_SEPARATOR(self):
        with open('ctnf_files/09933493-2008-11-13-00004-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 7, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 63, 64]
        },
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Yano  et al.',
            'ref_doc_num': '2006/0184546 A1',
            'claim_nums': [52, 53]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Yano et al.',
            'ref_doc_num': '2006/0184546   A1',
            'in_view_ref_name': 'Hailpern et al.',
            'in_view_ref_doc_num': '7,383,299',
            'in_further_view_ref_name': 'Chua et al.',
            'in_further_view_ref_doc_num': '2002/0049756 A1',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 54, 55, 56, 57, 58, 59, 60]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Yano et al.',
            'ref_doc_num': '2006/0184546 A1',
            'in_view_ref_name': 'Hailpern et al.',
            'in_view_ref_doc_num': '7,383,299',
            'in_further_view_ref_name': 'Chua et al.',
            'in_further_view_ref_doc_num': '2002/0049756 A1',
            'claim_nums': [24, 25, 26, 27, 63, 64]
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_multiple_rejected_claims(self):
        with open('ctnf_files/09271617-2003-09-03-00005-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': '“InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments” by BAYARDO et al',
            'claim_nums': [1, 3, 5, 6, 15, 16, 17, 39, 40]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': '“InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments" by BAYARDO et at  As to claims 7-10, BAYARDO teaches the agents are objects and a user agent communicates with data objects through a resource agent',
            'claim_nums': [7, 8, 9, 10, 18, 19, 20, 21, 25, 26, 27, 28]
        }]
        self.assertEqual(data, result)


    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_diff_doc_num_1(self):
        with open('ctfr_files/12317727-2011-02-10-00005-CTFR.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'claim_nums': [10, 11, 12, 13, 14, 15, 16, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56]
        },
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Sun et al',
            'ref_doc_num': 'U.S. Pub. No. 2004/0145602',
            'claim_nums': [10,11,12,13,14,15,16,44,45,46,47,48,49,50,51,52,53,54,55,56]
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_herinafter(self):
        with open('ctnf_files/09933493-2008-02-20-00004-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [{
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]
        },
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Yano  et al,',
            'ref_doc_num': '2006/0184546 A1',
            'claim_nums': [52, 53]
        }]
        self.assertEqual(data, result)

    """
    Should parse the doc num with hereinafter prepend text
    """
    def test_fr_for_ctnf_format_with_diff_doc_num_2(self):
        with open('ctnf_files/11403548-2009-09-30-00007-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': '112',
            'claim_nums': [14, 15, 16, 17, 18]
        },
        {
            'rejection_ground': '101',
            'claim_nums': [9, 10, 11, 12, 13]
        },
        {
            'claim_nums': [10, 11, 12, 13]
        },
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Alt',
            'ref_doc_num': '2007/0036143',
            'claim_nums': [14, 15, 16]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'AIt',
            'in_view_ref_name': 'Strathmeyer',
            'in_view_ref_doc_num': '2005/0122964',
            'claim_nums': [17, 18]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'AIt',
            'in_view_ref_name': 'Aasman',
            'in_view_ref_doc_num': '2003/0065737',
            'claim_nums': [1, 2, 3, 4, 5, 9, 10, 11, 12, 13]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'AIt',
            'in_view_ref_name': 'Aasman and Strathmeyer',
            'claim_nums': [6, 7, 8]
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with format of DOC_NUM first and REF_NAME second
    """
    def test_fr_for_ctnf_format_with_doc_num_first_ref_name_second(self):
        with open('ctnf_files/12290258-2010-04-02-00007-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '2005/0036656',
            'ref_name': 'Takahashi',
            'in_view_ref_doc_num': '6,282,362',
            'in_view_ref_name': 'Murphy',
            'claim_nums': [54, 55, 56, 57, 58, 60, 67, 72, 73]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '2005/0036656',
            'ref_name': 'Takahashi',
            'in_view_ref_doc_num': '6,282,362',
            'in_view_ref_name': 'Murphy',
            'in_further_view_ref_doc_num': '6,642,959',
            'in_further_view_ref_name': 'Arai',
            'claim_nums': [57, 61, 62, 63, 70, 71]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '2005/0036656',
            'ref_name': 'Takahashi',
            'in_view_ref_doc_num': '6,282,362',
            'in_view_ref_name': 'Murphy',
            'in_further_view_ref_doc_num': '7,006,146',
            'in_further_view_ref_name': 'Tanaka',
            'claim_nums': [59, 64, 65, 68]
        },
        {
            'claim_nums': [59]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '2005/0036656',
            'ref_name': 'Takahashi',
            'in_view_ref_doc_num': '6,282,362',
            'in_view_ref_name': 'Murphy',
            'in_further_view_ref_doc_num': '6,810,323',
            'in_further_view_ref_name': 'Bullock',
            'claim_nums': [66, 69]
        },
        {
            'claim_nums': [66]
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with doc num format  (US Patent 5,890,015)
    """
    def test_fr_for_ctnf_format_with_doc_num_us_patent_number(self):
        with open('ctnf_files/09632466-2002-11-27-00003-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Garney et at.',
            'ref_doc_num': '5,890,015',
            'claim_nums': [1, 2, 3, 4, 5, 7, 8, 9, 10]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Garney et al.',
            'ref_doc_num': '5,890,015',
            'claim_nums': [6, 11]
        }]
        self.assertEqual(data, result)

    """
    Should parse the CTNF with doc num format  (Pub. No.: US 2003/0043771 A1)
    """
    def test_fr_for_ctnf_format_with_doc_num_pub_no_us(self):
        with open('ctnf_files/09632466-2003-05-07-00002-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Mizutan et al.',
            'ref_doc_num': '2003/0043771 A1',
            'claim_nums': [1, 10]
        },
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Mizutani et al.',
            'ref_doc_num': '2003/0043771 A1',
            'claim_nums': [2, 3, 4, 5, 6, 7, 8, 9, 11]
        }]
        self.assertEqual(data, result)


    """
    Should parse the CTNF with doc num format  US. Patent No. 7,583,197
    """
    def test_fr_for_ctnf_format_with_doc_num_100(self):
        with open('ctnf_files/14159849-2014-10-08-00006-CTNF.txt') as ff:
            text = ff.read()
        data = frp.parse(text)
        result = [
        {
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Hayes, Jr. et al.',
            'ref_doc_num': '5,974,312',
            'in_view_ref_name': 'Anderson',
            'in_view_ref_doc_num': '5,995,603',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '7,583,197',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,094,010',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,633,802',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,542,111',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        },
        {
            'rejection_ground': 'nonstatutory obviousness-type double patenting',
            'rejection_reason': 'unpatentable',
            'ref_doc_num': '8,648,717',
            'claim_nums': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        }]
        self.assertEqual(data, result)

if __name__ == '__main__':
    unittest.main()