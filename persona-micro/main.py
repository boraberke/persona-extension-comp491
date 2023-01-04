from fastapi import FastAPI, HTTPException, Request
from WebCrawler import findURLsByKeyword, extractInfoFromTextV2
from EntityExtractorOpenAI import generate_entities
from fastapi.middleware.cors import CORSMiddleware
from deta import Deta
from typing import Union
from pydantic import BaseModel
#from dotenv import load_dotenv
import os

app = FastAPI(
    title="WebTrackApp",
    version="0.0.1",
)




#load_dotenv()


deta_project_key = os.getenv('DETA_PROJECT_KEY')
deta = Deta(deta_project_key)
db = deta.Base('personas')


app.add_middleware(
    CORSMiddleware,
    allow_origins= ["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class Persona(BaseModel):
    access_id :  Union[str, None] 
    name: Union[str, None] 
    age: Union[int, None] 
    location: Union[str, None] 
    profession: Union[str, None] 
    gender: Union[str, None] 
    marital_status: Union[str, None] 
    education: Union[str, None] 
    income: Union[str, None] 
    music_interest: Union[str, None] 
    book_interest: Union[str, None] 
    movies_interest: Union[str, None] 
    sport_interest: Union[str, None] 
    hobby: Union[str, None] 


@app.get("/")
def search_with_string(input :str):    
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


@app.get("/search-persona")
def search_with_persona(access_id,name):    
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


@app.post('/users/{access_id}')
def create_user(item: Persona, access_id):

    user = db.put({
        "access_id": access_id,
        "name": item.name,
        "age": item.age,
        "profession": item.profession,
        "gender": item.gender,
        "marital_status": item.marital_status,
        "education": item.education,
        "income": item.income,
        "music_interest": list(item.music_interest.split(',')),
        "book_interest": list(item.book_interest.split(',')),
        "movies_interest": list(item.movies_interest.split(',')),
        "sport_interest": list(item.sport_interest.split(',')),
        "hobby": list(item.hobby.split(','))
    })

    return user

@app.get("/users/{access_id}")
def get_user(access_id):
    
    personas = db.fetch({"access_id" : access_id})
    print(personas)
    if personas.count != 0:
        return personas 
    #access_id is not used before
    return {"_count": 0 , "_items" : []}



#@app.put("/users/<key>")
#def update_user(key):
#    user = db.put(request.json, key)
#    return user

@app.delete("/users/{access_id}/{name}")
def delete_user(access_id,name):
    persona = db.fetch({"access_id" : access_id, "name": name})
    if persona is not None:
        db.delete(persona)
        return {"status": "ok"}
    
    raise HTTPException(status_code=404, detail = f"There is no persona for access_id: '{access_id}' name: '{name}'")









    




