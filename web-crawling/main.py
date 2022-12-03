from fastapi import FastAPI
from WebCrawler import visitURLs,findURLsByKeyword




app = FastAPI(
    title="WebTrackApp",
    version="0.0.1",
)

@app.get("/")
def main_func(input :str):
    
    input_array = input.split(" ")
    return visitURLs(findURLsByKeyword(input_array))


    