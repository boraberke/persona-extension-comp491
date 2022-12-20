from bs4 import BeautifulSoup
import requests
import json


# queries = ["python", "stackoverflow", "github"]
def findURLsByKeyword(queries):
    # https://docs.python-requests.org/en/master/user/quickstart/#custom-headers
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
    }

    results = {}

    for query in queries:
        # https://docs.python-requests.org/en/master/user/quickstart/#passing-parameters-in-urls
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
            
            if query in resulted_link.lower():
                links.append(resulted_link)

        results[query] = links


    print("not json", results)
    #print(json.dumps(results, indent=2, ensure_ascii=False))

    
    return results


