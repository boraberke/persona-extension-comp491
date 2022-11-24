from bs4 import BeautifulSoup
import requests, lxml, json
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import threading
import json

from DoubleThreadMultitab import doubleThreadMultitab

# queries = ["python", "stackoverflow", "github"]
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
            
            if query in resulted_link.lower():
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
    driver_path = "chromedriver"

    for url in urlList:
        for link in url['links']:
            allURLs.append(link)

    doubleThreadMultitab(allURLs, driver_path)




queries = ["python", "stackoverflow", "github"]
visitURLs(findURLsByKeyword(queries))
