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
