import sys
from IPython import embed
import unittest

sys.path.insert(0, '..')

from final_rejection_parser import FinalRejectionParser

class FinalRejectionParserTest(unittest.TestCase):
    def setUp(self):
        self.frp = FinalRejectionParser()

    """
    Should capture the details from the straight forward input string
    """
    def test_fr_from_straight_ip_text(self):
        text = "Claims 50-51 are rejected under 35 U.S.C. 102(e) as being anticipated by Huang (6,362,748)"
        tree = self.frp.parse(text)
        data = tree.children

        self.assertEqual(len(data), 1)
        record_1 = {
            'claim_nums': [50, 51],
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Huang',
            'ref_doc_num': '6,362,748'
        }
        self.assertEqual(data[0], record_1)

    # """
    # Should capture the IN VIEW OF REF NAME and REF DOC NUM
    # """
    def test_fr_with_in_the_view_of(self):
        text = "Claims 2,4,5,11,14,17-19 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang (6,362,748) in view of Amro (6,292,747)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [2, 4, 5, 11, 14, 17, 18, 19],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'ref_doc_num': '6,362,748',
            'in_view_ref_name': 'Amro',
            'in_view_ref_doc_num': '6,292,747'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_of(self):
        text = "Claims 3,6,7,10,15 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in view of Knockeart (6,662,083)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [3, 6, 7, 10, 15],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_further_view_ref_name': 'Knockeart',
            'in_further_view_doc_num': '6,662,083'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_of_type_1(self):
        text = "Claims 12-13 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in view of Newell (US 2001/0142759 A1)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [12, 13],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Amro',
            'in_further_view_ref_name': 'Newell',
            'in_further_view_doc_num': 'US 2001/0142759 A1'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_of_type_2(self):
        text = "Claims 37-42, 46, 48-49 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski (7,257,426)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [37, 38, 39, 40, 41, 42, 46, 48, 49],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_view_ref_doc_num': '7,257,426'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_with_single_claim(self):
        text = "Claim 43 is rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Comerford (7,024,363)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [43],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_further_view_ref_name': 'Comerford',
            'in_further_view_doc_num': '7,024,363'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_with_applied_to(self):
        text = "Claims 44-45 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Newell (US 2002/0142759 A1)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [44, 45],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_further_view_ref_name': 'Newell',
            'in_further_view_doc_num': 'US 2002/0142759 A1'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_further_in_the_view_with_applied_to_2(self):
        text = "Claim 47 is rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Ohmura (US 2001/0048749 A1)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [47],
            'rejection_ground': '103(a)',
            'rejection_reason': 'unpatentable',
            'ref_name': 'Huang',
            'in_view_ref_name': 'Witkowski',
            'in_further_view_ref_name': 'Ohmura',
            'in_further_view_doc_num': 'US 2001/0048749 A1'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_simple_anticipated(self):
        text = "Claim 1 is rejected under 35 U.S.C. 102(e) as being anticipated by Chen (US 2005/0240672 A1)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [1],
            'rejection_ground': '102(e)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Chen',
            'ref_doc_num': 'US 2005/0240672 A1'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_ref_name_mutliple_words(self):
        text = "Claims 1,5,6,7,17,20,26,28,31-37 and 43-45 are rejected under 35 U.S.C. 102(b) as being anticipated by Barenwald et al (Patent No 5,782,371)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [1,5,6,7,17,20,26,28,31,32,33,34,35,36,37,43,44,45],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Barenwald et al',
            'ref_doc_num': '5,782,371'
        }
        self.assertEqual(data[0], record_1)

    def test_fr_with_claim_num_range(self):
        text = "Anti pattern Claims 1,2,5-7 and 9 are rejected under 35 U.S.C. 102(b) as being anticipated by Orikassa(US 2021102119414 A1)"
        tree = self.frp.parse(text)
        data = tree.children
        record_1 = {
            'claim_nums': [1, 2, 5, 6, 7, 9],
            'rejection_ground': '102(b)',
            'rejection_reason': 'anticipated',
            'ref_name': 'Orikassa',
            'ref_doc_num': 'US 2021102119414 A1'
        }
        self.assertEqual(data[0], record_1)

if __name__ == '__main__':
    unittest.main()