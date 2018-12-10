# coding: utf-8

import pyparsing as pp
import re
from IPython import embed

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

_ground_prefix_1 = pp.CaselessLiteral('under')
_ground_prefix_2 = pp.Each([
    pp.CaselessLiteral('on'),
    pp.CaselessLiteral('the'),
    pp.CaselessLiteral('ground'),
])

start = pp.Or([_start_1, _start_2, _start_3]).suppress()
claim_nums = pp.And([
    _claim_nums.setResultsName('claim_num_1'),
    pp.Optional(_and.suppress() + _claim_nums).setResultsName('claim_num_2')
])

rejected_str = pp.And([
    pp.Optional(pp.Or([pp.And([_is_literal, pp.Literal('/'), _are_literal]), _is_literal, _are_literal, _provis_literal])).suppress(),
    pp.CaselessLiteral('rejected'),
])

ground_prefix = pp.Or([
    _ground_prefix_1,
    _ground_prefix_2
])

rej_sent_grammer = pp.And([
    start,
    claim_nums,
    rejected_str,
    ground_prefix
])

def get_rej_sentences(rej_str):
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
    # Convert the whole file content to rejection sentences

    rej_sentence_idx = []
    rej_sentences = {}

    for result, st, en in rej_sent_grammer.scanString(rej_str):
        rej_sentence_idx.append(st)

    rej_sentence_idx.sort()
    idx_len = len(rej_sentence_idx)

    for idx in range(0, idx_len):
        start_idx = rej_sentence_idx[idx]
        end_idx = start_idx + 600

        if (idx + 1) <= (idx_len - 1) and end_idx >= rej_sentence_idx[idx + 1]:
            end_idx = rej_sentence_idx[idx + 1] - 1
        rej_sentences[start_idx] = rej_str[start_idx:end_idx]
    return rej_sentences
