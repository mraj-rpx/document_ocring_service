import sys
import re
import spacy
from IPython import embed

sys.path.insert(0, '..')

import rejection_sentence

nlp = spacy.load('./training_model')


def format_claims(ent):
    cached_c_nums = re.sub(r'[^0-9,-]', ',', ent.text).split(',')
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
    return {'ref_doc_num': ent.text.strip()}

ent_formatter = {
    'CLAIMS': format_claims,
    'GROUND': format_ground,
    'REASON': format_reason,
    'ORG': format_org,
    'PATENT': format_patent,
}

def get_rej_details(rej_str):
    rej_sentences = rejection_sentence.get_rej_sentences(rej_str)
    rejs_list = []
    for idx, sentence in rej_sentences.items():
        doc = nlp(sentence)
        rej_dict = {
            'rejection_sentence': sentence
        }
        for ent in doc.ents:
            rej_dict.update(ent_formatter[ent.label_](ent))
        rejs_list.append(rej_dict)
    return rejs_list
