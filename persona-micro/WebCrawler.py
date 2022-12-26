from bs4 import BeautifulSoup
import requests



def extractInfoFromTextV2(entity_dict):
    potential_entities = {"Location" : [' rental estate',' places to go'], 
                          "location" : [' rental estate',' places to go'], 
                          "interests" : [' events'],
                          "Interests" : [' events']}

    json_keys = entity_dict.keys()
    queries = []
    for key in json_keys:
        if key in potential_entities.keys():
            for value_list in potential_entities[key]:
                for value in entity_dict[key]:
                    queries.append(str(value) + str(value_list))
    

    #if queries.length < min_link_threshold: default ekle
    return queries
            

def findURLsByKeyword(queries):
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
        
        html = requests.get("https://www.google.com/search", params=params, headers=headers, timeout=15)
        soup = BeautifulSoup(html.text, "lxml")

        links = []
        
        for link in soup.select(".yuRUbf a"):
            resulted_link = link.get('href')
            links.append(resulted_link)

        results.append({
            "query": query,
            "links": links,
        })

    return results



