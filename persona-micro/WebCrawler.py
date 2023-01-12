from random import randint
from bs4 import BeautifulSoup
import requests


def extractInfoFromTextV2(entity_dict):
    potential_entities = {
                          "location" : [' rental estate',' places to go'], 
                          "interests" : [' events'],
                          "interest" : [' events'],
                          "nationality" : [' food'],
                            "product" : [' prices']
                          }
    json_keys = entity_dict.keys()
    if 'name' in json_keys:               
        entity_dict.pop('name')
    
    json_keys = entity_dict.keys()    

    queries = []
    for key in json_keys:
        if key.lower() in potential_entities.keys():
            for value_list in potential_entities[key.lower()]:
                if (type(entity_dict[key]) == list):
                    for value in entity_dict[key]:
                        queries.append(str(value) + str(value_list))
                elif (type(entity_dict[key]) == str):
                    if (entity_dict[key].lower() != 'unknown' and entity_dict[key].lower() != "unknown"):
                        queries.append(str(entity_dict[key]) + str(value_list))
        else:
            if (type(entity_dict[key]) == list):
                for value in entity_dict[key]:
                    queries.append(str(value))
            elif (type(entity_dict[key]) == str):
                if (entity_dict[key].lower() != 'unknown' and entity_dict[key].lower() != "unknown"):
                    queries.append(entity_dict[key])
    
    return queries


# KEYS:
# {"Music Interests": "Movie Interests": "Sport Interests": "Hobby": "Nationality": "Product": "Gender": "Age": "Name": "Location": "Profession": }
def extractInfoFromTextV3(entity_dict):
    queries = []
    json_keys = entity_dict.keys()

    for key in json_keys:
        value = entity_dict[key]

        # If value is a list, then we don't need to do anything
        # If value is a string, then we need to split it by comma and make a list
        if (type(value) == str):
            if "unknown" not in value.lower():
                value_arr = list(map(lambda x: x.strip(), value.split(",")))
            else:
                value_arr = []
        else:
            value_arr = value

        if key == "Profession":
            for val in value_arr:
                if "unknown" not in entity_dict["Location"].lower():
                    queries.append(val + ' jobs in ' + entity_dict["Location"])
                else:
                    queries.append(val + ' jobs')
        elif key == "Movie Interests":
            for val in value_arr:
                queries.append(val + ' letterboxd reviews')
                queries.append(val + ' film watch')
        elif key == "Music Interests":
            for val in value_arr:
                if "unknown" not in entity_dict["Location"].lower():
                    queries.append(val + ' concerts in ' + entity_dict["Location"])
                else:
                    queries.append(val + ' concerts')
        elif key == "Sport Interests":
            for val in value_arr:
                queries.append(val + ' match tickets')
        elif key == "Hobby":
            for val in value_arr:
                queries.append(val + ' events') 
        elif key == "Nationality":
            for val in value_arr:
                queries.append(val + ' food')
        elif key == "Product":
            for val in value_arr:
                queries.append(val + ' prices')
    
    return queries


# saved_persona = {
#   "access_id": "emresa",
#   "age": 23,
#   "location": "Istanbul",
#   "profession": "Student",
#   "gender": "Male",
#   "marital_status": "Single",
#   "education": "Bachelor's in Computer Science",
#   "income": "<$25,000",
#   "book_interest": [
#     "Andrzej Sapkowski"
#   ],
#   "movies_interest": [
#     "Henry Cavill"
#   ],
#   "music_interest": [
#     "Ramin Djawadi"
#   ],
#   "sport_interest": [
#     "Lionel Messi"
#   ],
#   "hobby": [
#     "FIFA 23"
#   ],
#   "key": "9pi57ar6gvfu",
#   "name": "Kerem"
# }

def extractInfoFromSavedPersona(saved_persona):
    keys = saved_persona.keys()
    queries = []

    for key in keys:
        value = saved_persona[key]

        if key == "profession":
            if saved_persona["location"] != None:
                queries.append(value + ' jobs in ' + saved_persona["location"])
            else:
                queries.append(value + ' jobs')
        elif key == "book_interest":
            for val in value:
                queries.append(val + ' book discussion')
                queries.append(val + ' book price')
        elif key == "movies_interest":
            for val in value:
                queries.append(val + ' letterboxd reviews')
                queries.append(val + ' film watch')
        elif key == "music_interest":
            for val in value:
                if saved_persona["location"] != None:
                    queries.append(val + ' concerts in ' + saved_persona["location"])
                else:
                    queries.append(val + ' concerts')
        elif key == "sport_interest":
            for val in value:
                queries.append(val + ' match tickets')
        elif key == "hobby":
            for val in value:
                queries.append(val + ' events') 

    return queries     
            

def findURLsByKeyword(queries):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
    }

    results = []
    limit = 0

    if len(queries) <= 3:
        limit = None

    for query in queries:
        params = {
            "q": query,
            "hl": "en",         # language
            "gl": "us"          # country of the search, US -> USA
        }
        
        html = requests.get("https://www.google.com/search", params=params, headers=headers, timeout=10)
        soup = BeautifulSoup(html.text, "lxml")

        links = []

        all_links = soup.select(".yuRUbf a")

        if limit is not None:   
            if len(all_links) >= 2:
                limit = randint(2, len(all_links))
                if limit > 6:
                    limit = 6
                all_links = all_links[:limit]
            else:
                all_links = all_links[:len(all_links)]

        for link in all_links:
            resulted_link = link.get('href')
            links.append(resulted_link)

        results.append({
            "query": query,
            "links": links,
        })

    return results

#[
#   {
#       "query": "Messi events",
#       "links": [
#           "https://timepath.co/lionel-messi",
#           "https://www.goal.com/en-us/news/how-old-is-lionel-messi-a-timeline-of-his-career-so-far/blt8c4ae3e9ea60e749",
#           "https://www.sutori.com/story/a-timeline-of-lionel-messi-s-soccer-career--Z5MHSN5gxyxJUD2CbaYAVq4q",
#           "https://www.cnn.com/interactive/2020/08/sport/lionel-messi-career-barcelona-spt-intl/",
#           "https://www.preceden.com/timelines/385879-lionel-messi",
#           "https://bleacherreport.com/articles/950467-lionel-messi-10-of-the-best-moments-of-his-career",
#           "https://www.foxsports.com/soccer/lionel-messi-player",
#           "https://www.independent.co.uk/topic/lionel-messi",
#           "https://historydraft.com/story/lionel-messi/timeline/204"
#       ]
#   }
#]
