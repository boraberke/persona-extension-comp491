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
                print(type(entity_dict[key]), "is type of", entity_dict[key])

                print(type(entity_dict[key]) != str)
                if (type(entity_dict[key]) != str):
                    for value in entity_dict[key]:
                        queries.append(str(value) + str(value_list))
                elif(entity_dict[key].lower() != 'unknown' and type(entity_dict[key]) == str):
                     queries.append(str(entity_dict[key]) + str(value_list))
        else:
            if (type(entity_dict[key]) != str):
                for value in entity_dict[key]:
                    queries.append(str(value))
            elif (type(entity_dict[key]) == str and entity_dict[key].lower() != 'unknown'):
                queries.append(entity_dict[key])

            
    

    #if queries.length < min_link_threshold: default ekle
    return queries

saved_persona = {
  "access_id": "emresa",
  "age": 23,
  "location": "Istanbul",
  "profession": "Student",
  "gender": "Male",
  "marital_status": "Single",
  "education": "Bachelor's in Computer Science",
  "income": "<$25,000",
  "book_interest": [
    "Andrzej Sapkowski"
  ],
  "movies_interest": [
    "Henry Cavill"
  ],
  "music_interest": [
    "Ramin Djawadi"
  ],
  "sport_interest": [
    "Lionel Messi"
  ],
  "hobby": [
    "FIFA 23"
  ],
  "key": "9pi57ar6gvfu",
  "name": "Kerem"
}

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
            

def findURLsByKeyword(queries, limit=None):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
    }

    results = []

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

        if len(all_links) > limit:
            all_links = all_links[:limit]
        
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
