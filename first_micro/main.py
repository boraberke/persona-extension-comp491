from fastapi import FastAPI
from WebCrawler import findURLsByKeyword, extractInfoFromTextV2
from EntityExtractorOpenAI import generate_entities
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI(
    title="WebTrackApp",
    version="0.0.1",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins= ["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def main_func(input :str):

    
    print("received input is:", input)

    print("Triggering generate entities")
    entities = generate_entities(input)

    print("Triggering generate entities is done. Result: ", entities)

    print("Triggering extract information from text")
    queries = extractInfoFromTextV2(entities)
    print("Triggerin extract information from text is done: ", queries)

    print("Triggering findURLsByKeyword ")
    result = findURLsByKeyword(queries)
    print("Triggering findURLsByKeyword is done. Result: ", result)

    return result


    