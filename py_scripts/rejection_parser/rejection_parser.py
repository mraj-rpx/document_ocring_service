import sys
import re
import spacy
from IPython import embed

sys.path.insert(0, '..')

import rejection_sentence

nlp = spacy.load('./training_model')


def format_claims(ent):
    cached_c_nums = re.sub(r'[^0-9,-]', ',', re.sub(r'\s', '', ent.text)).split(',')
    cached_c_nums = list(filter((lambda x: x.strip() != ''), cached_c_nums))
    c_nums = []

    for c_num in cached_c_nums:
        if '-' in c_num:
           c_num_range = c_num.split('-')
           c_nums = c_nums + list(range(int(c_num_range[0]), int(c_num_range[1]) + 1))
        else:
           c_nums.append(int(c_num))
    return {'claim_nums': c_nums}

def format_ground(ent):
    return {'rejection_ground': ent.text.strip()}

def format_reason(ent):
    return {'rejection_reason': ent.text.strip()}

def format_org(ent):
    return {'ref_name': ent.text.strip()}

def format_patent(ent):
    return {'ref_app_num': ent.text.strip()}


ent_formatter = {
    'CLAIMS': format_claims,
    'GROUND': format_ground,
    'REASON': format_reason,
    'ORG': format_org,
    'PATENT': format_patent
}

def get_sub_sent_ranges(rej_sent):
    sub_sents = rej_sent.split('view of')
    sent_ranges = []

    for sub_sent in sub_sents:
        sub_sent_idx = rej_sent.index(sub_sent)
        sub_sent_len = len(sub_sent)
        sub_sent_range = range(sub_sent_idx, sub_sent_idx + sub_sent_len)
        sent_ranges.append(sub_sent_range)
    return sent_ranges

def get_rej_details(rej_str):
    rej_sentences = rejection_sentence.get_rej_sentences(rej_str)
    rejs_list = []
    for idx, sentence in rej_sentences.items():
        doc = nlp(sentence)
        rej_dict = {
            'rejection_sentence': sentence
        }
        sub_sent_ranges = get_sub_sent_ranges(doc.text)
        citations = {}

        for ent in doc.ents:
            ent_value = ent_formatter[ent.label_](ent)

            if ent.label_ == 'ORG' or ent.label_ == 'PATENT':
                ent_idx = sentence.index(ent.text)
                for sub_sent_range in sub_sent_ranges:
                    key = "{0}-{1}".format(sub_sent_range.start, sub_sent_range.stop)
                    if not key in citations:
                        citations[key] = {}
                    citation = citations[key]

                    if ent_idx in sub_sent_range:
                        citation.update(ent_value)
            else:
                rej_dict.update(ent_value)

        rej_dict['citations'] = list(filter((lambda x: x != {}), citations.values()))
        rejs_list.append(rej_dict)
    return rejs_list
