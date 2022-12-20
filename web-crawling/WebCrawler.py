from bs4 import BeautifulSoup
import requests, lxml, json
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import threading
import json
from DoubleThreadMultitab import doubleThreadMultitab

# list of tuples
out_ex = [('Ufkun Ozalp', 'PERSON'), ('22 year old', 'DATE'), ('Turkish', 'NORP'), ('New York City', 'GPE'), ('Highway to Hell', 'WORK_OF_ART'), ('Ford', 'ORG'), ('Mustang GT 500', 'PRODUCT')]
queries = []
location = ''

for tuple in out_ex:
    if tuple[1] == 'GPE':
        location = tuple[0]
        queries.append(location + ' rental estate')
        queries.append(location + ' places to go')
    elif tuple[1] == 'WORK_OF_ART':
        if location != '':
            queries.append(tuple[0] + ' events in ' + location)
        else:
            queries.append(tuple[0] + ' events')
    elif tuple[1] == 'PRODUCT':
        queries.append(tuple[0] + ' prices')
    elif tuple[1] == 'NORP':
        queries.append(tuple[0] + ' food')

print(queries)

# queries = ["python", "stackoverflow", "github"] is a string array
def findURLsByKeyword(queries):
    # https://docs.python-requests.org/en/master/user/quickstart/#custom-headers
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
    }

    results = []

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
            links.append(resulted_link)

        results.append({
            "query": query,
            "links": links,
        })

    print(json.dumps(results, indent=2, ensure_ascii=False))

    resultJson = json.dumps(results, indent=2, ensure_ascii=False)
    return resultJson

# urlListJson = is a json string coming from the findURLsByKeyword function
def visitURLs(urlListJson):
    urlList = json.loads(urlListJson)
    allURLs = []
    driver_path = "../chromedriver"

    for url in urlList:
        for link in url['links']:
            allURLs.append(link)

    doubleThreadMultitab(allURLs, driver_path)

#queries = ["New York City", "Highway to Hell", "Mustang GT 500"]
findURLsByKeyword(queries)
#queries = ["python", "stackoverflow", "github"]
#visitURLs(findURLsByKeyword(queries))
