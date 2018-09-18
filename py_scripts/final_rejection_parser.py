from lark import Lark
from lark import Transformer
from IPython import embed

class FinalRejectionTransformer(Transformer):
    def claim_nums(self, nums):
        n = []
        for item in nums:
            if type(item) == list:
                for itm in item:
                    n.append(itm)
            else:
                n.append(item)
        return {'claim_nums': n}
    def claim_num(self, num):
        return int(num[0].value)
    def claim_num_range(self, rang):
        start_range = int(rang[0].value)
        end_range = int(rang[1].value) + 1
        return list(range(start_range, end_range))
    def rejection_ground(self, grnd):
        return {'rejection_ground': grnd[0].value}
    def rejection_reason(self, reason):
        return {'rejection_reason': reason[0].value}
    def ref_name(self, ref):
        return {'ref_name': ref[0].value}
    def ref_doc_num(self, ref_doc):
        return {'ref_doc_num': ref_doc[0].value}
    def in_view_ref_name(self, ref):
        return {'in_view_ref_name': ref[0].value}
    def in_view_doc_num(self, ref_doc):
        return {'in_view_ref_doc_num': ref_doc[0].value}
    def in_further_view_ref_name(self, ref):
        return {'in_further_view_ref_name': ref[0].value}
    def in_further_view_doc_num(self, ref_doc):
        return {'in_further_view_doc_num': ref_doc[0].value}
    def matches(self, m):
        attrs = {}
        for item in m:
            k = list(item.keys())[0]
            v = list(item.values())[0]
            attrs[k] = v
        return attrs

FINAL_REJECTION_GRAMMER = """
    start: matches*
    matches: _CLAIM_START claim_nums _rejection_str rejection_ground _rejection_reason_str rejection_reason _ref_str ref_name ref_doc_num
            | _CLAIM_START claim_nums _rejection_str rejection_ground _rejection_reason_str rejection_reason _ref_str ref_name ref_doc_num? _in_view_ref
            | _CLAIM_START claim_nums _rejection_str rejection_ground _rejection_reason_str rejection_reason _ref_str ref_name ref_doc_num? _in_view in_view_ref_name in_view_doc_num? _in_further_view_ref
    claim_nums: _claim_nums_by_comma? _COMMA? _claim_nums_by_range_rep? _COMMA? _claim_nums_by_comma? _COMMA? _claim_nums_by_range_rep? _AND? _claim_nums_by_comma?
    claim_nums_by_range: (NUMBER "-" NUMBER) -> claim_num_range
    rejection_ground: G_REJECTION_GROUND
    claim_num: NUMBER -> claim_num
    rejection_reason: G_REJECTION_REASON
    ref_name: WORD*
    ref_doc_num: "(" REF_DOC_NUM ")"
    in_view_ref_name: WORD*
    in_view_doc_num: "(" REF_DOC_NUM ")"
    in_further_view_ref_name: WORD*
    in_further_view_doc_num: "(" REF_DOC_NUM ")"

    _in_view_ref: _in_view in_view_ref_name in_view_doc_num
    _in_further_view_ref: "as applied to claim" _USC_NUMBER "above, and further in view of" in_further_view_ref_name in_further_view_doc_num

    _claim_nums_by_comma: claim_num (_COMMA claim_num)*
    _claim_nums_by_range_rep: claim_nums_by_range? (_COMMA claim_nums_by_range)*
    _rejection_str: _single_or_multiple_claims "rejected under" _USC_NUMBER "U.S.C."
    _rejection_reason_str: "as being"
    _ref_str: "by" | "over"
    _in_view: "in view of"
    _in_further_view_ref_str: "as applied to claim" _USC_NUMBER "above, and"
    _single_or_multiple_claims: "is" | "are"

    _CLAIM_START: "Claims" | "Claim"
    _COMMA: ","
    _AND: "and"
    _USC_NUMBER: NUMBER
    _G_REJECTION_CODE: "(" LETTER ")"
    SLASH: "/"

    _G_REJECTION_NUM: "101"| "102" | "103" | "112"
    _REF_DOC_NUM_1: NUMBER "," NUMBER "," NUMBER
    _REF_DOC_NUM_2: /US\s\d+\/\d+\sA\d+/

    G_REJECTION_GROUND: _G_REJECTION_NUM _G_REJECTION_CODE
    G_REJECTION_REASON: "anticipated" | "unpatentable"
    REF_DOC_NUM: _REF_DOC_NUM_1 | _REF_DOC_NUM_2

    %import common.NUMBER
    %import common.WS
    %import common.LETTER
    %import common.WORD
    %ignore WS
"""

class FinalRejectionParser:
    def __init__(self):
        self.lark = Lark(FINAL_REJECTION_GRAMMER, start='start')

    def parse(self, rejection_str):
        tree = self.lark.parse(rejection_str)
        print(tree.pretty())
        transformed_collection = FinalRejectionTransformer().transform(tree)
        return transformed_collection

"""
    claim_nums: (NUMBER | claim_nums_with_range) -> claim_nums
    claim_nums_with_range: (NUMBER "-" "NUMBER") -> claim_nums_with_range

"""

"""
Claims 50-51 are rejected under 35 U.S.C. 102(e) as being anticipated by Huang (6,362,748).

1. claim numbers: 50-51
2. rejection ground: 102(e)
3. rejection reason: anticipated
4. refernce name: Huang
5. reference document number: 6,362,748

Claims 2,4,5,11,14,17-19 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang (6,362,748) in view of Amro (6,292,747)

1. claim numbers: 2,4,5,11,14,17-19
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Amro
5. reference document number: 6,292,747

Claims 3,6,7,10,15 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of amro as applied to claim 2 above, and further in the view of Knockeart (6,662,083)

1. claim numbers: 3,6,7,10,15
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Knockeart
5. reference document number: 6,662,083

claims 12-13 are rejected under U.S.C. 103(a) as being unpatentable over Huang in view of Amro as applied to claim 2 above, and further in the view of Newell (US 2001/0142759 A1)

1. claim numbers: 12-13
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Newell
5. reference document number: US 2001/0142759 A1

Claims 37-42, 46, 48-49 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski (7,257, 426)

1. claim numbers: 37-42, 46, 48-49
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Witkowski
5. reference document number: 7,257, 426

Claim 43 is rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Comerford (7,024,363)

1. claim numbers: 43
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Comerford
5. reference document number: 7,024,363

claims 44-45 are rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in the view of Newell (US 2002/0142759 A1)

1. claim numbers: 44-45
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Newell
5. reference document number: US 2002/0142759 A1

claim 47 is rejected under 35 U.S.C. 103(a) as being unpatentable over Huang in view of Witkowski as applied to claim 37 above, and further in view of Ohmura (US 2001/0048749 A1)

1. claim numbers: 47
2. rejection ground: 103(a)
3. rejection reason: unpatentable
4. refernce name: Ohmura
5. reference document number: US 2001/0048749 A1

"""