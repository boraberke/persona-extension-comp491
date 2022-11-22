from bs4 import BeautifulSoup
import requests, lxml, json

# https://docs.python-requests.org/en/master/user/quickstart/#custom-headers
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36",
}

queries = ["python", "stackoverflow", "github"]

results = []

for query in queries:
    # https://docs.python-requests.org/en/master/user/quickstart/#passing-parameters-in-urls
    params = {
        "q": query,
        "hl": "en",         # language
        "gl": "us"          # country of the search, US -> USA
    }
    
    html = requests.get("https://www.google.com/search", params=params, headers=headers, timeout=30)
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