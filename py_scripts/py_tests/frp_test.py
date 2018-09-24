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
            'in_further_view_ref_doc_num': 'US2001/0142759A1'
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
            'in_further_view_ref_doc_num': 'US2002/0142759A1'
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
            'ref_doc_num': 'US2005/0240672A1'
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

if __name__ == '__main__':
    unittest.main()