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
        (59, 65, 'GROUND'),
        (75, 87, 'REASON'),
        (192, 205, 'ORG')
    ]}),
    # ANTICIPATED
    ("Claims 1, 3, 5, 6, 15-17, 39, and 40 are rejected under 35 U.S.C. 102(b) as being anticipated by “InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments” by BAYARDO et al.  As to claim 1, BAYARDO teaches a computer-implemented method for communication and cooperative task completion between a community of distributed electronic agents communicating using a dynamically expandable interagent- communication language, ICL, (KQML) (pg. 197, Agent Communication Language) and  at least on other distributed component system (Resource Agent system), the other   dis", {
    'entities': [
        (0, 36, 'CLAIMS'),
        (66, 72, 'GROUND'),
        (82, 93, 'REASON'),
        (195, 209, 'ORG')
    ]}),
    ("Claims 1, 3, and 14 are rejected under 35 U.S.C. 112, rst paragraph, as containing subject matter which was not described in the specication in such a way as to enable one skilled in the art to which it pertains, or with which it is most nearly connected, to make and/or use the invention. Applicant has not provided a detailed disclosure of “counting requests exclusive of repeated requests from common clients”. The examiner is aware of page 7, lines 17-18 and page 14, lines 9-11 of the disclosure where applicant states “counting requests excluding repeated requests from common clients” if there", {
    'entities': [
        (0, 19, 'CLAIMS'),
        (49, 52, 'GROUND')
    ]}),
    # format USC.
    ("Claims 3-6 and 11-12 rejected under 35 USC. 102(a) as being anticipated by Lara D. Catledge et al., Characterizing Browsing Strategies in the WorId-Wide Web (hereafter referred to as Cartledge).  11. Regarding claim 3, Catledge taught an information server on a network,  comprising:   means for responding to requests for service received from a client through a network by returning the requested service to the client (users request documents through www.gatechedu, page 3); and  means for counting requests to a particular service (“A modied version of the Pattern Detection Module (PDM) algorith", {
    'entities': [
        (0, 20, 'CLAIMS'),
        (44, 50, 'GROUND'),
        (60, 71, 'REASON'),
        (75, 98, 'ORG')
    ]}),


    # ref_name and app_num
    ("Claims 1-5 and 7-10 are rejected under 35 U.S.C. 102(e) as being anticipated by Garney et at. (US Patent 5,890,015) a. As per claims 1 and 10, Garney discloses wireless USB hub comprising:  - a data reception circuit for receiving data in a wireless manner from the one or more remote wireless peripheral devices; (coi.5, lines 30-47), (fig.5, 520)  - an upstream port connected to the computer; (fig.4), (co|.5, lines  18-29)   - a hub controller for passing information from the data reception circuit to the upstream port for transmission to the computer. (col.5, lines 18-47), (fig.5, 420) b. As", {
    'entities': [
        (0, 19, 'CLAIMS'),
        (49, 55, 'GROUND'),
        (65, 76, 'REASON'),
        (80, 93, 'ORG'),
        (95, 114, 'PATENT')
    ]}),
    # app num with pub no. US:
    ("Claims 1 and 10 are rejected under 35 U.S.C. 102(e) as being anticipated by Mizutan et al. (Pub No. :US 2003/0043771 A1) a. As per claims 1 and 10, Mizutan discloses wireless USB hub comprising: = a data reception circuit for receiving data in a wireless manner from the one or more remote wireless peripheral devices; (see abstract and [0014], wherein wireless hub perform communication with computer and devices, converts to a USB package routed to device and vice versa, transceiver transmit and receive data from devices) - an upstream port connected to the computer; ([0116], wherein upstream to", {
    'entities': [
        (0, 15, 'CLAIMS'),
        (45, 51, 'GROUND'),
        (61, 72, 'REASON'),
        (76, 90, 'ORG'),
        (92, 119, 'PATENT')
    ]}),
    # hereinafter for first app num
    ("Claims 1- 15, 17, 20-21, 24-27, 29-33 are rejected under 35 U.S.C. 102(b) as  being anticipated by Zimowski et ai. (hereinafter “Zim”, US Patent 5,632,015).  As per claims 1, 20-21, 24, 29, 32-33, Zim discloses a system, user interface mechanism, and method of providing session-based retrieval and at a client system of string-based content from a server comprising:  A communication protocol that enables an asynchronous session based connection between a client system and a server system, and allows the client system  to send, within a single session between the client system and the server sys", {
    'entities': [
        (0, 37, 'CLAIMS'),
        (67, 73, 'GROUND'),
        (84, 95, 'REASON'),
        (99, 114, 'ORG'),
        (135, 154, 'PATENT')
    ]}),
    ("Claims 52-53 are rejected under 35 U.S.C. 102(e) as being anticipated by Yano  et al. (hereinafter “Yano”, US Patent Publication 2006/0184546 A1).  As per claims 52-53, Yano discloses a system and method for suggesting data as a response to client requests, comprising: a server configured to receive requests from a plurality of clients for content  (paragraphs [0035, 0045, 0061]);  an interface to a plurality of databases or data sources of content information coupled to  said server (paragraphs [0037, 0042, 0045, 0058]);   a communication protocol that provides a session connection between a", {
    'entities': [
        (0, 12, 'CLAIMS'),
        (42, 48, 'GROUND'),
        (58, 69, 'REASON'),
        (73, 85, 'ORG'),
        (107, 144, 'PATENT')
    ]}),
    ("Claims 2-9, 11 are rejected under 35 U.S.C. 103(a) as being unpatentable over Mizutani et al. (Pub. No.: US 2003/0043771 A1)  a. As per claim 2, Mizutani discloses data reception circuit further includes  receiver (fig.1, 21) for receiving wireless information from at least one of  the one or more remote peripheral devices. [0047]  Although Mizutani fails to disclose RF receiver for receiving wireless information. Mizutani does teach transceiver(g.1,21)  Examiner take Ofcial Notice that RF receiver and transceiver are well known in' the art for providing a means of receiving wireless informati", {
    'entities': [
        (0, 14, 'CLAIMS'),
        (44, 50, 'GROUND'),
        (60, 72, 'REASON'),
        (78, 93, 'ORG'),
        (95, 123, 'PATENT')
    ]}),


    # with in view ref name and app num
    ("Claims 1- 27 are rejected under 35 U.S.C. 103(a) as being unpatentable over Purcell (US 2001/0013038 A1) in view of Hughes et al. (hereinafter “Hughes”, US 2003/0195876 A1_). As per claims 1, 19-24, Purcell discloses a system and user interface mechanism for session based retrieval and at a client system of content from a server system, said server system serving a string based content, said string based content including a plurality of strings, comprising:  a communication protocol that provides a session based connection between a client system and a server system, and allows said client sy", {
    'entities': [
        (0, 12, 'CLAIMS'),
        (42, 48, 'GROUND'),
        (58, 70, 'REASON'),
        (76, 83, 'ORG'),
        (85, 103, 'PATENT'),
        (116, 129, 'ORG_1'),
        (153, 172, 'PATENT_1')
    ]}),
    # hereinafter for both normal and in view ref
    ('Claims 1- 15, 17, 24-27, 29-37 are rejected under 35 U.S.C. 103(a) as being unpatentable over Zimowski et al. (hereinafter “Zim”, US Pateht 5,632,015) in view of  Spaey et al. (hereinafter “Spaey", US Patent Publication 2002/0055981 A1).  As per claims 1, 24, 29, 32-33, Zim discloses a system, user interface mechanism, and method of providing session-based retrieval and at a client system of string-based content from a server comprising:  0 - A communication protocol that enables session based connection between a  client system and a server system, and allows the client system to send, within', {
    'entities': [
        (0, 30, 'CLAIMS'),
        (60, 66, 'GROUND'),
        (76, 88, 'REASON'),
        (94, 109, 'ORG'),
        (130, 149, 'PATENT'),
        (163, 175, 'ORG_1'),
        (198, 235, 'PATENT_1')
    ]}),


    ('Claims 1- 15, 17, 29-51, 54-60 are rejected under 35 U.S.C. 103(a) as being  unpatentable over Yano et al. (hereinafter “Yano”, US Patent Publication 2006/0184546   A1) in view of Hailpern et al. (hereinafter “Hail”, US Patent 7,383,299 Bi) and in further  view of Chua et al. (hereinafter "Chua", US Patent Publication 2002/0049756 A1).  As per claims 1, 29, 32-33, Yano discloses a system, user interface mechanism,  and method of providing session-based retrieval and at a client system of string-based  content from a server comprising:  A communication protocol that enables connection over a ne', {
    'entities': [
        (0, 30, 'CLAIMS'),
        (60, 66, 'GROUND'),
        (77, 89, 'REASON'),
        (95, 106, 'ORG'),
        (128, 167, 'PATENT'),
        (180, 195, 'ORG_1'),
        (217, 239, 'PATENT_1'),
        (265, 276, 'ORG_2'),
        (298, 335, 'PATENT_2')
    ]}),

    # 4 REFERENCES
    ('Claims 24-27, 63-64 are rejected under 35 U.S.C. 103(a) as being unpatentable over Yano et al. (hereinafter “Yano”, US Patent Publication 2006/0184546 A1) in view of Hailpern et al. (hereinafter “Hail”, US Patent 7,383,299 B1) in further view of Chua et al. (hereinafter "Chua", US Patent Publication 2002/0049756 A1) and in further view of Vora et. al (hereinafter “Vora”, US Patent 6,539,379 B1). As per claims 24, 63-64, Yano discloses a user interface mechanism and system comprising:  . a communication protocol that enables connection over a network between a  client system and a server system', {
    'entities': [
        (0, 19, 'CLAIMS'),
        (49, 55, 'GROUND'),
        (65, 77, 'REASON'),
        (83, 94, 'ORG'),
        (116, 153, 'PATENT'),
        (166, 181, 'ORG_1'),
        (203, 225, 'PATENT_1'),
        (246, 257, 'ORG_2'),
        (279, 316, 'PATENT_2'),
        (341, 352, 'ORG_3'),
        (374, 396, 'PATENT_3')
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
        nlp = spacy.blank('en')  # create blank Language class
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
    ner.add_label('ORG_1')
    ner.add_label('PATENT_1')
    ner.add_label('ORG_2')
    ner.add_label('PATENT_2')
    ner.add_label('ORG_3')
    ner.add_label('PATENT_3')
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
