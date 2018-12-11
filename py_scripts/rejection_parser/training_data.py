# coding: utf-8

from __future__ import unicode_literals, print_function
import plac
import random
from pathlib import Path
import spacy
from spacy.util import minibatch, compounding


# new entity label
LABELS = ['CLAIMS', 'GROUND', 'REASON', 'ORG', 'PATENT']

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
    ("Claims 1, 3, 5, 6, 15-17, 39, and 40 are rejected under 35 U.S.C. 102(b) as being anticipated by “InfoSIeuth: Agent-Based Semantic Integration of Information in Open and Dynamic Environments” by BAYARDO et al.  As to claim 1, BAYARDO teaches a computer-implemented method for communication and cooperative task completion between a community of distributed electronic agents communicating using a dynamically expandable interagent- communication language, ICL, (KQML) (pg. 197, Agent Communication Language) and  at least on other distributed component system (Resource Agent system), the other   dis", {
    'entities': [
        (0, 36, 'CLAIMS'),
        (66, 72, 'GROUND'),
        (82, 93, 'REASON'),
        (195, 209, 'ORG')
    ]}),
    #ground and reason
    ("Claims 14-18 are rejected under 35 U.S.C. 112, second paragraph, as being indefinite for failing to particularly point out and distinctly claim the subject matter which applicant regards as the invention.  The first 2 limitations of claim 14 appear to occur in the alternative. This is noted by limitation 3, stating “responsive to one or more of the first and second communication  request.... It is unclear what limitations are actually part of the claim, which limitations always occur, and which may only occur in certain circumstances. The Examiner has taken the first 2 limitations in the alter", {
    'entities': [
        (0, 12, 'CLAIMS'),
        (42, 45, 'GROUND'),
        (74, 84, 'REASON')
    ]}),

    #only claims and ground
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
    ("Claims 149-151 are rejected under 35 U.S.C. 103(a) as being unpatentable over Ogawa et al as applied to claim 148 above, and further in view of the following comments]  Ogawa et al discloses the claimed invention except for forming a bond between said rst and second bonding surfaces at room temperature with a strength of at least 500 mJ/mz, 1000 mJ/mz, and 2000 mJ/m2. It would have been obvious to one having ordinary skill in the art at the time the invention was made to determine a suitable bond strength between the rst and second bonding surfaces, since it has been held that where the genera", {
    'entities': [
        (0, 14, 'CLAIMS'),
        (44, 50, 'GROUND'),
        (60, 72, 'REASON'),
        (78, 89, 'ORG')
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
    ("Claim 148 is rejected under 35 U.S.C. 102(b) as being anticipated by Ogawa et al (US. Patent 5,437,894). -  Ogawa et al discloses a bonding method, comprising forming- rst and second materials having rst and second bonding surfaces, respectively, etching said rst and second bonding surfaces (Column 9, lines 55-65, and Column 31, lines 53-67), bringing into direct contact said rst and second bonding surfaces after said etching step, and forming a chemical bond near room  temperature between said rst and second bonding surfaces (Column 32, lines 10-63). ", {
    'entities': [
        (0, 9, 'CLAIMS'),
        (38, 44, 'GROUND'),
        (54, 65, 'REASON'),
        (69, 80, 'ORG'),
        (82, 102, 'PATENT')
    ]}),
    ("Claims 14-16 are rejected under 35 U.S.C. 102(e) as being anticipated by Alt (US. Patent Application Publication 2007/0036143). Regarding Claim 14,  Alt discloses a method for communicating comprising:   Establishing a first communication connection between a first internal controller behind a firewall and a first external controller in a first communication community, wherein a first communication request is initiated by a local communication device connected to the first internal controller (Figures 2 and 6; and Paragraphs 48, 57, and 95-97; as described above, there is a discrepancy between", {
    'entities': [
        (0, 12, 'CLAIMS'),
        (42, 48, 'GROUND'),
        (58, 69, 'REASON'),
        (73, 76, 'ORG'),
        (78, 125, 'PATENT')
    ]}),

    # with in view ref name and app num
    ("Claims 1- 27 are rejected under 35 U.S.C. 103(a) as being unpatentable over Purcell (US 2001/0013038 A1) in view of Hughes et al. (hereinafter “Hughes”, US 2003/0195876 A1_). As per claims 1, 19-24, Purcell discloses a system and user interface mechanism for session based retrieval and at a client system of content from a server system, said server system serving a string based content, said string based content including a plurality of strings, comprising:  a communication protocol that provides a session based connection between a client system and a server system, and allows said client sy", {
    'entities': [
        (0, 12, 'CLAIMS'),
        (42, 48, 'GROUND'),
        (58, 70, 'REASON'),
        (76, 83, 'ORG'),
        (85, 103, 'PATENT'),
        (116, 129, 'ORG'),
        (153, 172, 'PATENT')
    ]}),
    # hereinafter for both normal and in view ref
    ('Claims 1- 15, 17, 24-27, 29-37 are rejected under 35 U.S.C. 103(a) as being unpatentable over Zimowski et al. (hereinafter “Zim”, US Pateht 5,632,015) in view of  Spaey et al. (hereinafter “Spaey", US Patent Publication 2002/0055981 A1).  As per claims 1, 24, 29, 32-33, Zim discloses a system, user interface mechanism, and method of providing session-based retrieval and at a client system of string-based content from a server comprising:  0 - A communication protocol that enables session based connection between a  client system and a server system, and allows the client system to send, within', {
    'entities': [
        (0, 30, 'CLAIMS'),
        (60, 66, 'GROUND'),
        (76, 88, 'REASON'),
        (94, 109, 'ORG'),
        (130, 149, 'PATENT'),
        (163, 175, 'ORG'),
        (198, 235, 'PATENT')
    ]}),
    #two org and one patent
    ('Claims 17 and 18 are rejected under 35 U.S.C. 103(a) as being unpatentable over AIt in view of Strathmeyer (US. Patent Application Publication 2005/0122964). Regarding Claim 17, Alt discloses that establishing the third communication connection comprises: Issuing a third communication request to a central communication controller (Figure 4; and Paragraphs 95-100, step 413, for example); Establishing a first central communication channel between the first external communication controller and the central communication controller (Figure 4; and Paragraphs 95-100, steps 413 and 415, for example, ', {
    'entities': [
        (0, 16, 'CLAIMS'),
        (46, 52, 'GROUND'),
        (62, 74, 'REASON'),
        (80, 83, 'ORG'),
        (95, 106, 'ORG'),
        (108, 155, 'PATENT')
    ]}),
    ("Claims 54-57, 58, 60, 67, 72 and 73 are rejected under 35 U.S.C. 103(a) as being unpatentable over US 2005/0036656 (Takahashi) in view of US 6,282,362  (Murphy).  5. As to claim 54, Takahashi teaches an image verification device comprising:  a user verification module 7 for verifying an identity of a user of the device, wherein upon verification, the user verification module enables operation of the device (Figs. 1 and 7, when the user is verified the camera is enabled);  a capture module for capturing at least one image and creating a digital image file, wherein the user verification module v", {
    'entities': [
        (0, 35, 'CLAIMS'),
        (65, 71, 'GROUND'),
        (81, 93, 'REASON'),
        (99, 114, 'PATENT'),
        (116, 125, 'ORG'),
        (138, 150, 'PATENT'),
        (153, 159, 'ORG')
    ]}),

    # 3 ORG and PATENT
    ('Claims 1- 15, 17, 29-51, 54-60 are rejected under 35 U.S.C. 103(a) as being  unpatentable over Yano et al. (hereinafter “Yano”, US Patent Publication 2006/0184546   A1) in view of Hailpern et al. (hereinafter “Hail”, US Patent 7,383,299 Bi) and in further  view of Chua et al. (hereinafter "Chua", US Patent Publication 2002/0049756 A1).  As per claims 1, 29, 32-33, Yano discloses a system, user interface mechanism,  and method of providing session-based retrieval and at a client system of string-based  content from a server comprising:  A communication protocol that enables connection over a ne', {
    'entities': [
        (0, 30, 'CLAIMS'),
        (60, 66, 'GROUND'),
        (77, 89, 'REASON'),
        (95, 106, 'ORG'),
        (128, 167, 'PATENT'),
        (180, 195, 'ORG'),
        (217, 239, 'PATENT'),
        (265, 276, 'ORG'),
        (298, 335, 'PATENT')
    ]}),
    ("Claims 57, 61-63, 70 and 71 are rejected under 35 U.S.C. 103(a) as being unpatentable over US 2005/0036656 (Takahashi) in view of US 6,282,362 (Murphy) further in view of US 6,642,959 (Arai).  13. As to claim 57, see the rejection of claim 54 and note that neither Takahashi nor Murphy teach the display module adapted to prompt a user to input information regarding the captured image. However, Arai teaches a digital camera with a display 12 that is adapted to prompt a user to input information regarding a captured image (Fig. 8). Therefore it would have been obvious to one of ordinary skill in '", {
    'entities': [
        (0, 27, 'CLAIMS'),
        (57, 63, 'GROUND'),
        (73, 85, 'REASON'),
        (91, 106, 'PATENT'),
        (108, 117, 'ORG'),
        (130, 142, 'PATENT'),
        (144, 150, 'ORG'),
        (171, 183, 'PATENT'),
        (185, 189, 'ORG')]
    }),
    ("Claims 66 and 69 are rejected under 35 U.S.C. 103(a) as being unpatentable over US 2005/0036656 (Takahashi) in view of US 6,282,362 (Murphy) further in view of US 6,810,323 (Bullock).  24. As to claim 66, see the rejection of claim 54 and note that neither Takahashi nor Murphy teach displaying direction to the location of a captured image. However, Bullock teaches providing a map service that displays directions to the location of a captured image (C2 L49-55 and C7 L66 to CS L14). Therefore it would have been obvious to one of ordinary skill in the art at the time the invention was made to hav", {
    'entities': [
        (0, 16, 'CLAIMS'),
        (46, 52, 'GROUND'),
        (62, 74, 'REASON'),
        (80, 95, 'PATENT'),
        (97, 106, 'ORG'),
        (119, 131, 'PATENT'),
        (133, 139, 'ORG'),
        (160, 172, 'PATENT'),
        (174, 181, 'ORG')
    ]}),

    # 4 REFERENCES
    ('Claims 24-27, 63-64 are rejected under 35 U.S.C. 103(a) as being unpatentable over Yano et al. (hereinafter “Yano”, US Patent Publication 2006/0184546 A1) in view of Hailpern et al. (hereinafter “Hail”, US Patent 7,383,299 B1) in further view of Chua et al. (hereinafter "Chua", US Patent Publication 2002/0049756 A1) and in further view of Vora et. al (hereinafter “Vora”, US Patent 6,539,379 B1). As per claims 24, 63-64, Yano discloses a user interface mechanism and system comprising:  . a communication protocol that enables connection over a network between a  client system and a server system', {
    'entities': [
        (0, 19, 'CLAIMS'),
        (49, 55, 'GROUND'),
        (65, 77, 'REASON'),
        (83, 94, 'ORG'),
        (116, 153, 'PATENT'),
        (166, 181, 'ORG'),
        (203, 225, 'PATENT'),
        (246, 257, 'ORG'),
        (279, 316, 'PATENT'),
        (341, 352, 'ORG'),
        (374, 396, 'PATENT')
    ]}),


    #compund ORG names
    ('Claims 6-8 are rejected under 35 U.S.C. 103(a) as being unpatentable over Mizutani in view of Aasman and Steve.  Regarding Claim 6,   Alt as modified by Aasman discloses the method of claim 1, in addition, Alt discloses a communication request requesting to communicate with an external endpoint not connected to one or more of the controller and the at least one other controIIer (Figure 2; and Paragraphs 59 and 101-110); but does not explicitly disclose issuing a central request from the external controller to a central controIIer responsive to the communication request requesting to communica', {
    'entities': [
        (0, 10, 'CLAIMS'),
        (40, 46, 'GROUND'),
        (56, 68, 'REASON'),
        (74, 82, 'ORG'),
        (94, 110, 'ORG')
    ]}),
    ("Claims 1-2, 7-10 are rejected under 35 U.S.C. 103(a) as being unpatentable over Lara D. Catledge et al., Characterizing Browsing Strategies in the WorId-Wide Web (hereafter referred to as Cartledge) in view of Jos Kahan, A capability-based authorization model for the World Wide Web (hereafter referred to as Kahan). 3. Regarding claim 1, Catledge taught a method of processing service requests from a client to a server system through a network, said comprising the steps of:  responding to requests for information received from the client through the  network by returning the requested informatio", {
    'entities': [
        (0, 16, 'CLAIMS'),
        (46, 52, 'GROUND'),
        (62, 74, 'REASON'),
        (80, 103, 'ORG'),
        (210, 219, 'ORG')
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

    for LABEL in LABELS:
        ner.add_label(LABEL)

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
