import spacy as spacy
import gender_guesser.detector as gender

d = gender.Detector()
nlp = spacy.load("en_core_web_trf")


def ner_model(text):
    doc = nlp(text)
    entities = []
    entities.append((extract_gender(text), 'GENDER'))
    for entity in doc.ents:
        entities.append((entity.text, entity.label_))
    return entities


def extract_gender(text):
    doc = nlp(text)
    pronouns = [token.text for token in doc if token.pos_ in ["PRON", "PRP", "PRP$"] or token.text in ["he", "she", "her", "him", "his", "hers", "herself", "himself", "man", "woman"]]

    name = None
    for token in doc:
        if token.pos_ == "PROPN" and d.get_gender(token.text) != "unknown":
            name = token.text
            break
    if name is not None:
        gender = d.get_gender(name)

    elif pronouns:
        if "she" in pronouns or "her" in pronouns or "woman" in pronouns:
            gender = "female"
        elif "he" in pronouns or "him" in pronouns or "man" in pronouns:
            gender = "male"
        else:
            gender = "unknown"
    else:
        gender = "unknown"

    return gender


### Test ###
#text = 'Ufkun Ozalp is a 22 year old Turkish man from New York City who likes listening jazz while driving his Ford Mustang GT 500.'
#text = 'Bora is 25 years old, has 25 million dollars and likes travelling and cooking'
#text = "John is a software engineer and enjoys writing code and solving problems. He also likes to play video games and watch movies in his free time."
#entities = ner_model(text)
#print(entities)

