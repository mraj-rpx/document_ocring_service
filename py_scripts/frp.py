import pyparsing as pp
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

_claim_nums_by_comma = pp.Word(pp.nums) + pp.Optional(_comma).suppress()
_claim_nums_by_range = pp.Word(pp.nums) + _hyphen.suppress() + pp.Word(pp.nums) + pp.Optional(_comma).suppress()
_claim_nums_by_range_group = pp.Group(_claim_nums_by_range)
_claim_nums_by_num_or_range = pp.Or([_claim_nums_by_comma, _claim_nums_by_range_group])
_claim_nums = pp.ZeroOrMore(_claim_nums_by_num_or_range)

_is_literal = pp.CaselessLiteral('is')
_are_literal = pp.CaselessLiteral('are')

_rejected_str = pp.And([
    pp.Or([pp.And([_is_literal, pp.Literal('/'), _are_literal]), _is_literal, _are_literal]).suppress(),
    pp.CaselessLiteral('rejected')
])

_rejection_ground_prefix_str = pp.And([
    _rejected_str,
    pp.CaselessLiteral('under'),
    pp.Word(pp.nums),
    pp.CaselessLiteral('U.S.C.')
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
    pp.CaselessLiteral('being')
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

_ref_doc_num_prepend_options = pp.Or([
    pp.And([
        pp.CaselessLiteral('patent'),
        pp.Or([
            pp.CaselessLiteral('no'),
            pp.CaselessLiteral('no.')
        ])
    ]),
    pp.And([
        pp.CaselessLiteral('u'),
        pp.Optional(pp.CaselessLiteral('.')),
        pp.CaselessLiteral('s.'),
        pp.CaselessLiteral('patent'),
        pp.Optional(pp.CaselessLiteral('no.'))
    ]),
    pp.CaselessLiteral('us')
])

_ref_doc_num_1 = pp.Combine(pp.And([
    pp.Word(pp.nums, exact=1),
    pp.Literal(','),
    pp.Word(pp.nums, exact=3),
    pp.Literal(','),
    pp.Word(pp.nums, exact=3)
]))

_ref_doc_num_2 = pp.originalTextFor(pp.Combine(pp.And([
    pp.CaselessLiteral('us'),
    pp.Word(pp.nums),
    pp.Literal('/'),
    pp.Word(pp.nums),
    pp.Word(pp.alphas),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_3 = pp.And([
    _ref_doc_num_prepend_options.suppress(),
    _ref_doc_num_1
])

_ref_doc_num_4 = pp.originalTextFor(pp.Combine(pp.And([
    pp.CaselessLiteral('us'),
    pp.CaselessLiteral('pub.'),
    pp.CaselessLiteral('no.'),
    pp.Word(pp.nums),
    pp.Literal('/'),
    pp.Word(pp.nums)
]), adjacent=False))


_ref_doc_num_5 = pp.originalTextFor(pp.Combine(pp.And([
    pp.CaselessLiteral('us'),
    pp.Word(pp.nums),
    pp.Word(pp.alphas, exact=1),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_6 = pp.originalTextFor(pp.Combine(pp.And([
    pp.CaselessLiteral('us'),
    pp.Word(pp.nums)
]), adjacent=False))

_ref_doc_num_7 = pp.And([
    _ref_doc_num_prepend_options.suppress(),
    pp.Word(pp.nums)
])

_ref_doc_num = pp.Or([
    _ref_doc_num_1,
    _ref_doc_num_2,
    _ref_doc_num_3,
    _ref_doc_num_4,
    _ref_doc_num_5,
    _ref_doc_num_6,
    _ref_doc_num_7
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
    _in_further_view_ref_prefix_str_1
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

_in_view_of_prefix_str_for_103_1 = pp.CaselessLiteral('and in view of')

in_view_of_prefix_str_for_103 = pp.Or([
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

grammer_2 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_skip_to).setResultsName('ref_name').setParseAction(strip_ref_name),
    in_view_skip_to,
    pp.SkipTo(in_view_ref_doc_num).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    in_view_ref_doc_num
])

grammer_3 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_skip_to).setResultsName('ref_name').setParseAction(strip_ref_name),
    in_view_skip_to,
    pp.SkipTo(in_view_ref_name_skip_to).setResultsName('in_view_ref_name').setParseAction(strip_ref_name),
    in_view_ref_name_skip_to,
    pp.SkipTo(in_further_view_ref_doc_num).setResultsName('in_further_view_ref_name').setParseAction(strip_ref_name),
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
grammer_8 = pp.And([
    start,
    claim_nums,
    rejection_ground,
    rejection_reason,
    ref_prefix_str.suppress(),
    pp.SkipTo(in_view_of_prefix_str_for_103, failOn=grammer_6).setResultsName('ref_name').setParseAction(strip_ref_name),
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

grammers = [
    grammer_6,
    grammer_9,
    grammer_7,
    grammer_8,
    grammer_4,
    grammer_1,
    grammer_2,
    grammer_3,
    grammer_5
]

def claim_num_fun(claims):
    nums = []
    for num in claims:
        if type(num) == list:
            nums = nums + list(range(int(num[0]), int(num[1]) + 1))
        else:
            nums.append(int(num))
    return nums

def parse(rej_str):
    data = {}
    rej_str = rej_str.replace('\n', ' ')
    for grammer in grammers:
        for result, st, en in grammer.scanString(rej_str):
            rr = result.asDict()
            c_num_1 = rr.get('claim_num_1')
            c_num_2 = rr.get('claim_num_2')
            c_nums = []

            if c_num_1:
                c_nums = c_nums + claim_num_fun(c_num_1)
                del(rr['claim_num_1'])
            if c_num_2:
                c_nums = c_nums + claim_num_fun(c_num_2)
                del(rr['claim_num_2'])
            rr['claim_nums'] = c_nums
            data[st] = rr
        # print("FINISHING A GRAMMER===========")
        # embed()
    # embed()
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
    pp.Combine(_rejection_date).setResultsName('rejection_date')
])

def parse_rej_date(filename):
    result = filename_parser.parseString(filename)
    return result.asDict()
"""
Claims 50-51 are rejected under 35 U.S.C. 102(e) as being anticipated by Huang (6,362,748)
"""