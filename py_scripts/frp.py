import pyparsing as pp
import re
from IPython import embed


def join_matched_list(matched_list):
    return ''.join(matched_list[0])

def strip_ref_name(matched_list):
    return ' '.join(matched_list).strip()

def format_doc_num(matched_list):
    return matched_list[0].strip()

_start_1 = pp.CaselessLiteral("claims")
_start_2 = pp.CaselessLiteral("claim")
_start_3 = pp.CaselessLiteral("claim(s)")
_and = pp.CaselessLiteral('and')

_comma = pp.Literal(',')
_hyphen = pp.Literal('-')
_open_bracket = pp.Literal('(')
_close_bracket = pp.Literal(')')

_claim_nums_by_comma = pp.Word(pp.nums) + pp.Optional(_comma).suppress()
_claim_nums_by_range = pp.Word(pp.nums) + _hyphen.suppress() + pp.Word(pp.nums) + pp.Optional(_comma).suppress()
_claim_nums_by_range_group = pp.Group(_claim_nums_by_range)
_claim_nums_by_num_or_range = pp.Or([_claim_nums_by_comma, _claim_nums_by_range_group])
_claim_nums = pp.ZeroOrMore(_claim_nums_by_num_or_range)

_is_literal = pp.CaselessLiteral('is')
_are_literal = pp.CaselessLiteral('are')
_provis_literal = pp.CaselessLiteral('provisionally')

_rejected_str = pp.And([
    pp.Optional(pp.Or([pp.And([_is_literal, pp.Literal('/'), _are_literal]), _is_literal, _are_literal, _provis_literal])).suppress(),
    pp.CaselessLiteral('rejected')
])

_rejection_ground_prefix_str = pp.And([
    _rejected_str,
    pp.CaselessLiteral('under'),
    pp.Optional(pp.CaselessLiteral('pre-AIA')),
    pp.Word(pp.nums),
    pp.And([
        pp.CaselessLiteral('U'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('S'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('C'),
        pp.Optional(pp.CaselessLiteral('.'))
    ])
])

_rejection_ground_prefix_str_100 = pp.And([
    _rejected_str,
    pp.CaselessLiteral('on the ground of'),
])

_rejection_ground_type_1 = pp.originalTextFor(pp.And([
    pp.CaselessLiteral('nonstatutory'),
    pp.Optional(pp.And([
        pp.CaselessLiteral('obviousness'),
        _hyphen,
        pp.CaselessLiteral('type'),
    ])),
    pp.CaselessLiteral('double'),
    pp.CaselessLiteral('patenting')
]))

_rejection_ground_type = pp.Or([
    _rejection_ground_type_1
])

_rejection_code = pp.And([
    pp.Word(pp.nums, exact=3),
    pp.Optional(pp.And([
        pp.Literal('('),
        pp.Word(pp.alphas, exact=1),
        pp.Literal(')')
    ]))
])

_rejection_reason_prefix_str = pp.And([
    pp.Optional(pp.CaselessLiteral('as')),
    pp.CaselessLiteral('being'),
    pp.Optional(pp.CaselessLiteral('clearly'))
])

_rejection_reason = pp.Or([
    pp.CaselessLiteral('anticipated'),
    pp.CaselessLiteral('unpatentable')
])

_in_further_view_ref_prefix_str_1 =  pp.And([
    pp.CaselessLiteral('as applied to claim'),
    pp.Optional(pp.CaselessLiteral('s')),
    pp.Word(pp.nums),
    pp.Optional(pp.And([pp.CaselessLiteral('and'), pp.Word(pp.nums)])),
    pp.CaselessLiteral('above, and further in view of')
])

_in_further_view_ref_prefix_str_2 = pp.And([
    pp.Optional(pp.CaselessLiteral('and')),
    pp.Each([
        pp.CaselessLiteral('in'),
        pp.CaselessLiteral('further'),
        pp.CaselessLiteral('view'),
        pp.CaselessLiteral('of')
    ])
])

_special_char_dbl_quote_start = pp.Or([
    pp.CaselessLiteral('“'),
    pp.CaselessLiteral('"'),
])
_special_char_dbl_quote_end = pp.Or([
    pp.CaselessLiteral('”'),
    pp.CaselessLiteral('"')
])

_ref_name_with_quoted = pp.And([
    _special_char_dbl_quote_start,
    pp.SkipTo(_special_char_dbl_quote_end),
    _special_char_dbl_quote_end
])

_ref_doc_num_prepend_options = pp.Or([
    pp.Each([
        pp.CaselessLiteral('patent'),
        pp.Or([
            pp.CaselessLiteral('no'),
            pp.CaselessLiteral('no.')
        ]),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('u'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('s'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('patent'),
        pp.Optional(pp.CaselessLiteral('publication')),
        pp.Optional(pp.CaselessLiteral('no.')),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('u'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('s'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('patent'),
        pp.CaselessLiteral('application'),
        pp.CaselessLiteral('publication'),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('u'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('s'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('pub')),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('no')),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('#')),
        pp.Optional(pp.CaselessLiteral('patent')),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('#')),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('u'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('s'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('patent'),
        pp.CaselessLiteral('application'),
        pp.CaselessLiteral(','),
        pp.CaselessLiteral('pub'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('no'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral(':'),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('copending'),
        pp.CaselessLiteral('application'),
        pp.CaselessLiteral('no.'),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('hereinafter'),
        _ref_name_with_quoted,
        pp.CaselessLiteral(','),
        pp.Optional(pp.CaselessLiteral('u')),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('s')),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.Optional(pp.CaselessLiteral('patent')),
        pp.Optional(pp.CaselessLiteral('pateht')),
        pp.Optional(pp.CaselessLiteral('number')),
        pp.Optional(pp.CaselessLiteral('publication')),
        pp.Optional(pp.CaselessLiteral('application'))
    ]),
    pp.Each([
        pp.CaselessLiteral('pub'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('no'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral(':'),
        pp.CaselessLiteral('us'),
        pp.Optional(pp.CaselessLiteral('number'))
    ]),
    pp.Each([
        pp.CaselessLiteral('cited')
    ])
])

_ref_doc_num_1 = pp.originalTextFor(pp.Combine(pp.And([
    pp.Word(pp.nums, exact=1),
    pp.Literal(','),
    pp.Word(pp.nums, exact=3),
    pp.Literal(','),
    pp.Word(pp.nums, exact=3)
]), adjacent=False))

_ref_doc_num_2 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    pp.Word(pp.nums),
    pp.Literal('/'),
    pp.Word(pp.nums),
    pp.Word(pp.alphas),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_2_without_us = pp.originalTextFor(pp.Combine(pp.And([
    pp.Word(pp.nums),
    pp.Literal('/'),
    pp.Word(pp.nums),
    pp.Word(pp.alphas),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_3 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    _ref_doc_num_1
]), adjacent=False))

_ref_doc_num_4 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    pp.Word(pp.nums),
    pp.Literal('/'),
    pp.Word(pp.nums)
]), adjacent=False))


_ref_doc_num_5 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    pp.Word(pp.nums),
    pp.Word(pp.alphas, exact=1),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_6 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_7 = pp.originalTextFor(pp.Combine(pp.And([
    _ref_doc_num_prepend_options,
    pp.Word(pp.nums + '/,')
]), adjacent=False))

_ref_doc_num_8 = pp.originalTextFor(pp.Combine(pp.And([
    pp.Optional(_ref_doc_num_prepend_options),
    _ref_doc_num_2,
    pp.Optional(pp.CaselessLiteral('_'))
]), adjacent=False))

_ref_doc_num_9 = pp.originalTextFor(pp.Combine(pp.And([
    pp.Optional(_ref_doc_num_prepend_options),
    _ref_doc_num_2_without_us
]), adjacent=False))

_ref_doc_num_1_additional = pp.And([
    _ref_doc_num_1,
    pp.Word(pp.alphanums, exact=2)
])

_ref_doc_num_10 = pp.originalTextFor(pp.Combine(pp.And([
    pp.Optional(_ref_doc_num_prepend_options),
    _ref_doc_num_1_additional
]), adjacent=False))

_ref_doc_num = pp.Or([
    _ref_doc_num_1,
    _ref_doc_num_2,
    _ref_doc_num_3,
    _ref_doc_num_4,
    _ref_doc_num_5,
    _ref_doc_num_6,
    _ref_doc_num_7,
    _ref_doc_num_8,
    _ref_doc_num_9,
    _ref_doc_num_10
])

_ref_doc_num_100_prefix_100 = pp.And([
    pp.CaselessLiteral('over claim'),
    pp.Optional(pp.CaselessLiteral('s')),
    _claim_nums,
    pp.Optional(pp.And([
        pp.CaselessLiteral('and'),
        _claim_nums
    ])),
    pp.CaselessLiteral('of')
])

_following_comments = pp.Or([
    pp.CaselessLiteral('the following comments')
])

start = pp.Or([_start_1, _start_2, _start_3]).suppress()
claim_nums = pp.And([
    _claim_nums.setResultsName('claim_num_1'),
    pp.Optional(_and.suppress() + _claim_nums).setResultsName('claim_num_2')
])

rejection_ground = pp.And([
    _rejection_ground_prefix_str.suppress(),
    pp.Group(_rejection_code).setParseAction(join_matched_list).setResultsName('rejection_ground')
])

rejection_ground_100 = pp.And([
    _rejection_ground_prefix_str_100,
    pp.Group(_rejection_ground_type).setParseAction(join_matched_list).setResultsName('rejection_ground')
])

rejection_reason = pp.And([
    _rejection_reason_prefix_str.suppress(),
    _rejection_reason.setResultsName('rejection_reason')
])

ref_doc_num = pp.And([
    pp.Literal('(').suppress(),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    pp.Literal(')').suppress(),
])

ref_doc_num_100 = pp.And([
    _ref_doc_num_100_prefix_100,
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
])

in_view_ref_doc_num = pp.And([
    pp.Literal('(').suppress(),
    _ref_doc_num.setResultsName('in_view_ref_doc_num').setParseAction(format_doc_num),
    pp.Literal(')').suppress(),
])

in_further_view_ref_doc_num = pp.And([
    pp.Literal('(').suppress(),
    _ref_doc_num.setResultsName('in_further_view_ref_doc_num').setParseAction(format_doc_num),
    pp.Literal(')').suppress(),
])

ref_prefix_str = pp.Or([
    pp.CaselessLiteral('by'),
    pp.CaselessLiteral('over')
])

in_view_ref_prefix_str = pp.Or([
    pp.CaselessLiteral('in view of')
])

in_further_view_ref_prefix_str = pp.Or([
    _in_further_view_ref_prefix_str_1,
    _in_further_view_ref_prefix_str_2
])

opt_ref_doc_num = pp.Optional(ref_doc_num)

in_view_skip_to = pp.And([
    pp.Optional(ref_doc_num),
    in_view_ref_prefix_str.suppress()
])

in_view_ref_name_skip_to = pp.And([
    pp.Optional(in_view_ref_doc_num),
    in_further_view_ref_prefix_str.suppress()
])

further_following = pp.And([
    _in_further_view_ref_prefix_str_1,
    _following_comments
])

skip_to_next_first_dot = pp.Literal('.')

_in_view_of_prefix_str_for_103_1 = pp.And([
    pp.Optional(pp.CaselessLiteral('and')),
    pp.CaselessLiteral('in view of')
])

in_view_of_prefix_str_for_103 = pp.Or([
    ref_doc_num,
    _in_view_of_prefix_str_for_103_1
])

grammer_1 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(ref_doc_num).setResultsName('ref_name').setParseAction(strip_ref_name),
    ref_doc_num
])

_rejected_under_usc = pp.And([
    pp.CaselessLiteral('rejected'),
    pp.CaselessLiteral('under'),
    pp.Word(pp.nums),
    pp.CaselessLiteral('U.S.C.')
])
_rejected_under = pp.And([
    pp.CaselessLiteral('rejected'),
    pp.CaselessLiteral('under'),
])

failon_for_g_2 = pp.Or([
    grammer_1,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_2 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_skip_to, failOn=failon_for_g_2).setResultsName('ref_name').setParseAction(strip_ref_name),
    in_view_skip_to,
    pp.SkipTo(in_view_ref_doc_num, failOn=failon_for_g_2).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    in_view_ref_doc_num
])

failon_for_g_3 = pp.Or([
    grammer_2,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_3 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_skip_to, failOn=failon_for_g_3).setResultsName('ref_name').setParseAction(strip_ref_name),
    in_view_skip_to,
    pp.SkipTo(in_view_ref_name_skip_to, failOn=failon_for_g_3).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    in_view_ref_name_skip_to,
    pp.SkipTo(in_further_view_ref_doc_num, failOn=failon_for_g_3).setResultsName('in_further_view_ref_name').setParseAction(strip_ref_name),
    in_further_view_ref_doc_num
])

grammer_4 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(further_following, failOn=ref_doc_num).setResultsName('ref_name').setParseAction(strip_ref_name),
    further_following
])

grammer_5 = pp.And([
    start,
    claim_nums,
    rejection_ground_100,
    rejection_reason,
    ref_doc_num_100
])

grammer_6 = pp.And([
    start,
    claim_nums,
    _rejected_str
])

# grammer_7 should be executed before grammer_1, so that if doc num exist then it will get overrided
grammer_7 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(skip_to_next_first_dot, failOn=in_view_of_prefix_str_for_103).setResultsName('ref_name').setParseAction(strip_ref_name),
    skip_to_next_first_dot
])


# grammer_8 should be executed after grammer_7
failon_for_g_8 = pp.Or([
    grammer_6,
    _rejection_ground_prefix_str,
    _rejected_str,
    skip_to_next_first_dot
])

grammer_8 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_of_prefix_str_for_103, failOn=failon_for_g_8).setResultsName('ref_name').setParseAction(strip_ref_name),
    in_view_of_prefix_str_for_103,
    pp.SkipTo(skip_to_next_first_dot).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    skip_to_next_first_dot
])

# Grammer_9 should be immediate after grammer 6 to capture rejection ground
grammer_9 = pp.And([
    start,
    claim_nums,
    rejection_ground
])

grammer_10 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket).setResultsName('ref_name').setParseAction(strip_ref_name),
    _close_bracket
])

failon_for_g_11 = pp.Or([
    grammer_10,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_11 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket, failOn=failon_for_g_11).setResultsName('ref_name').setParseAction(strip_ref_name),
    _close_bracket,
    in_view_ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('in_view_ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket, failOn=failon_for_g_11).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    _close_bracket
])

failon_for_g_12 = pp.Or([
    grammer_11,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_12 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket, failOn=failon_for_g_12).setResultsName('ref_name').setParseAction(strip_ref_name),
    _close_bracket,
    in_view_ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('in_view_ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket, failOn=failon_for_g_12).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    _close_bracket,
    in_further_view_ref_prefix_str.suppress(),
    _ref_doc_num.setResultsName('in_further_view_ref_doc_num').setParseAction(format_doc_num),
    _open_bracket,
    pp.SkipTo(_close_bracket, failOn=failon_for_g_12).setResultsName('in_further_view_ref_name').setParseAction(strip_ref_name),
    _close_bracket
])
"""
"""
_common_ref_doc_num =  pp.And([
    pp.CaselessLiteral('('),
    _ref_doc_num,
    pp.CaselessLiteral(')')
])

failon_for_g_13 = pp.Or([
    _common_ref_doc_num,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_13 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_13).setResultsName('ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num)
])

failon_for_g_14 = pp.Or([
    grammer_13,
    _common_ref_doc_num,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_14 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_14).setResultsName('ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    in_view_ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_14).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('in_view_ref_doc_num').setParseAction(format_doc_num)
])

failon_for_g_15 = pp.Or([
    grammer_14,
    _common_ref_doc_num,
    _rejection_ground_prefix_str,
    _rejected_str,
    _rejected_under_usc,
    _rejected_under
])

grammer_15 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_15).setResultsName('ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('ref_doc_num').setParseAction(format_doc_num),
    in_view_ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_15).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('in_view_ref_doc_num').setParseAction(format_doc_num),
    in_further_view_ref_prefix_str.suppress(),
    pp.SkipTo(_ref_doc_num, failOn=failon_for_g_15).setResultsName('in_further_view_ref_name').setParseAction(strip_ref_name),
    _ref_doc_num.setResultsName('in_further_view_ref_doc_num').setParseAction(format_doc_num)
])

"""
"""
grammers = [
    grammer_6,    #1
    grammer_9,    #2
    grammer_7,    #3
    grammer_8,    #4
    grammer_4,    #5
    grammer_1,    #6
    grammer_2,    #7
    grammer_3,    #8
    grammer_5,    #9
    grammer_13,  #10
    grammer_14,  #11
    grammer_15,  #12
    grammer_10,  #13
    grammer_11,  #14
    grammer_12   #15
]

def claim_num_fun(claims):
    nums = []
    for num in claims:
        if type(num) == list:
            nums = nums + list(range(int(num[0]), int(num[1]) + 1))
        else:
            nums.append(int(num))
    return nums

def format_data(rr):
    c_num_1 = rr.get('claim_num_1')
    c_num_2 = rr.get('claim_num_2')
    c_nums = []

    if c_num_1:
        c_nums = c_nums + claim_num_fun(c_num_1)
        del(rr['claim_num_1'])
    if c_num_2:
        c_nums = c_nums + claim_num_fun(c_num_2)
        del(rr['claim_num_2'])

    if 'claim_num_1' in rr:
        del(rr['claim_num_1'])
    if 'claim_num_2' in rr:
        del(rr['claim_num_2'])
    rr['claim_nums'] = c_nums
    return rr

def parse(rej_str):
    data = {}
    remove_line_idx = []
    lines = rej_str.split("\n")
    for index, line in enumerate(lines):
        stripped_line = line.strip()
        if stripped_line.startswith('Application/Control Number') or line.startswith('Art Unit:'):
            remove_line_idx.append(index)
    for idx in list(reversed(remove_line_idx)):
        del(lines[idx])
    rej_str = ' '.join(lines).strip()

    # Replace UNICODE CHARS \U2010, \U2012-\u2015 BY dash(-)
    rej_str = re.sub(r'[\u2010\u2012-\u2015]', r'-', rej_str)
    # Replace the NON-ASCII chars by SPACE
    rej_str = re.sub(r'[^\x00-\x7f“”]', r'', rej_str)
    grammer_idx = 1

    for grammer in grammers:
        for result, st, en in grammer.scanString(rej_str):
            rr = format_data(result.asDict())
            data[st] = rr
        # print("FINISHING GRAMMER: {0}".format(grammer_idx))
        # grammer_idx = grammer_idx + 1

    invalid_ref_name_idx = {}

    for idx in data:
        rej_data = data[idx]
        fields = []

        if 'ref_name' in rej_data and len(rej_data['ref_name']) > 255:
            fields.append('ref_name')
        if 'in_view_ref_name' in rej_data and len(rej_data['ref_name']) > 255:
            fields.append('in_view_ref_name')
        if 'in_further_view_ref_name' in rej_data and len(rej_data['ref_name']) > 255:
            fields.append('in_further_view_ref_name')
        if fields:
            invalid_ref_name_idx[idx] = fields

    ref_name_data = {}

    for grammer in [grammer_7, grammer_8]:
        for result, st, en in grammer.scanString(rej_str):
            rr = format_data(result.asDict())
            ref_name_data[st] = rr

    for idx in invalid_ref_name_idx:
        fields = invalid_ref_name_idx[idx]
        field_vals = {}
        doc_num_field = None

        for field in fields:
            if field == 'ref_name':
                field_vals = {'ref_name': ref_name_data[idx]['ref_name']}
                doc_num_field = 'ref_doc_num'
            elif field == 'in_view_ref_name':
                field_vals = {'in_view_ref_name': ref_name_data[idx]['in_view_ref_name']}
                doc_num_field = 'in_view_ref_doc_num'
            elif field == 'in_further_view_ref_name':
                field_vals = {'in_further_view_ref_name': ref_name_data[idx]['in_further_view_ref_name']}
                doc_num_field = 'in_further_view_ref_doc_num'
        data[idx].update(field_vals)
        if doc_num_field in data[idx]:
            del(data[idx][doc_num_field])

    return list(data.values())

_rejection_date = pp.And([
    pp.Word(pp.nums, exact=4),
    _hyphen,
    pp.Word(pp.nums, exact=2),
    _hyphen,
    pp.Word(pp.nums, exact=2),
])

filename_parser = pp.And([
    pp.Word(pp.nums).setResultsName('app_num'),
    _hyphen,
    pp.Combine(_rejection_date).setResultsName('mailing_date')
])

def parse_rej_date(filename):
    result = filename_parser.parseString(filename)
    return result.asDict()
"""
Claims 50-51 are rejected under 35 U.S.C. 102(e) as being anticipated by Huang (6,362,748)
"""