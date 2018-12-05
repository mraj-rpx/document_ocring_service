# coding: utf-8

from __future__ import unicode_literals, print_function
import plac
import random
from pathlib import Path
import spacy
from spacy.util import minibatch, compounding


# new entity label
LABEL = 'CLAIMS'

# training data
# Note: If you're using an existing model, make sure to mix in examples of
# other entity types that spaCy correctly recognized before. Otherwise, your
# model might learn the new type, but "forget" what it previously knew.
# https://explosion.ai/blog/pseudo-rehearsal-catastrophic-forgetting
TRAIN_DATA = [
    # UNPATENTABLE
    ("Claims 7-10, 18-21, and 25-28 are rejected under 35 U.S.C. 103(a) as being unpatentable over “InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments\" by BAYARDO et at  As to claims 7-10, BAYARDO teaches the agents are objects and a user agent communicates with data objects through a resource agent. However, BAYARDO does not teach that the other distributed component system utilizes a distributed object  service or that service is Jini, Corba, or Java service. “Official Notice” is taken that JINI,  . .   CORBA, and Java are well-known object oriented softwa", {
    'entities': [
        (0, 29, 'CLAIMS'),
        (49, 65, 'GROUND'),
        (75, 87, 'REASON'),
        (192, 205, 'ORG')
    ]}),
    # ANTICIPATED
    ("Claims 1, 3, 5, 6, 15-17, 39, and 40 are rejected under 35 U.S.C. 102(b) as being anticipated by “InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments” by BAYARDO et al.  As to claim 1, BAYARDO teaches a computer-implemented method for communication and cooperative task completion between a community of distributed electronic agents communicating using a dynamically expandable interagent- communication language, ICL, (KQML) (pg. 197, Agent Communication Language) and  at least on other distributed component system (Resource Agent system), the other   dis", {
    'entities': [
        (0, 36, 'CLAIMS'),
        (56, 72, 'GROUND'),
        (82, 93, 'REASON'),
        (195, 209, 'ORG')
    ]}),
    ("Claims 1, 3, and 14 are rejected under 35 U.S.C. 112, rst paragraph, as containing subject matter which was not described in the specication in such a way as to enable one skilled in the art to which it pertains, or with which it is most nearly connected, to make and/or use the invention. Applicant has not provided a detailed disclosure of “counting requests exclusive of repeated requests from common clients”. The examiner is aware of page 7, lines 17-18 and page 14, lines 9-11 of the disclosure where applicant states “counting requests excluding repeated requests from common clients” if there", {
    'entities': [
        (0, 19, 'CLAIMS'),
        (39, 52, 'GROUND')
    ]}),
    # format USC.
    ("Claims 3-6 and 11-12 rejected under 35 USC. 102(a) as being anticipated by Lara D. Catledge et al., Characterizing Browsing Strategies in the WorId-Wide Web (hereafter referred to as Cartledge).  11. Regarding claim 3, Catledge taught an information server on a network,  comprising:   means for responding to requests for service received from a client through a network by returning the requested service to the client (users request documents through www.gatechedu, page 3); and  means for counting requests to a particular service (“A modied version of the Pattern Detection Module (PDM) algorith", {
    'entities': [
        (0, 20, 'CLAIMS'),
        (36, 50, 'GROUND'),
        (60, 71, 'REASON'),
        (75, 98, 'ORG')
    ]})
]

@plac.annotations(
    model=("Model name. Defaults to blank 'en' model.", "option", "m", str),
    new_model_name=("New model name for model meta.", "option", "nm", str),
    output_dir=("Optional output directory", "option", "o", Path),
    n_iter=("Number of training iterations", "option", "n", int))
def main(model=None, new_model_name='claims', output_dir=Path('./training_model'), n_iter=100):
    """Set up the pipeline and entity recognizer, and train the new entity."""
    if model is not None:
        nlp = spacy.load(model)  # load existing spaCy model
        print("Loaded model '%s'" % model)
    else:
        nlp = spacy.load('en')  # create blank Language class
        print("Created blank 'en' model")
    # Add entity recognizer to model if it's not in the pipeline
    # nlp.create_pipe works for built-ins that are registered with spaCy
    if 'ner' not in nlp.pipe_names:
        ner = nlp.create_pipe('ner')
        nlp.add_pipe(ner)
    # otherwise, get it, so we can add labels to it
    else:
        ner = nlp.get_pipe('ner')

    ner.add_label(LABEL)
    ner.add_label('ORG')
    ner.add_label('GROUND')
    ner.add_label('REASON')
    ner.add_label('PATENT')
      # add new entity label to entity recognizer
    if model is None:
        optimizer = nlp.begin_training()
    else:
        # Note that 'begin_training' initializes the models, so it'll zero out
        # existing entity types.
        optimizer = nlp.entity.create_optimizer()

    # get names of other pipes to disable them during training
    other_pipes = [pipe for pipe in nlp.pipe_names if pipe != 'ner']
    with nlp.disable_pipes(*other_pipes):  # only train NER
        for itn in range(n_iter):
            random.shuffle(TRAIN_DATA)
            losses = {}
            # batch up the examples using spaCy's minibatch
            batches = minibatch(TRAIN_DATA, size=compounding(4., 32., 1.001))
            for batch in batches:
                texts, annotations = zip(*batch)
                nlp.update(texts, annotations, sgd=optimizer, drop=0.35,
                           losses=losses)
            print('Losses', losses)

    # test the trained model
    test_text = 'Claims 3-6, 11-12 rejected under 35 U.S.C. 102(a) as being anticipated by Lara D. Catledge et al.'
    doc = nlp(test_text)
    print("Entities in '%s'" % test_text)
    for ent in doc.ents:
        print(ent.label_, ent.text)

    # save model to output directory
    if output_dir is not None:
        output_dir = Path(output_dir)
        if not output_dir.exists():
            output_dir.mkdir()
        nlp.meta['name'] = new_model_name  # rename model
        nlp.to_disk(output_dir)
        print("Saved model to", output_dir)

        # test the saved model
        print("Loading from", output_dir)
        nlp2 = spacy.load(output_dir)
        doc2 = nlp2(test_text)
        for ent in doc2.ents:
            print(ent.label_, ent.text)

if __name__ == '__main__':
    plac.call(main)
