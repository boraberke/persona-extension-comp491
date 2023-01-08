from fastapi import FastAPI, HTTPException, Request
from WebCrawler import findURLsByKeyword, extractInfoFromTextV3,extractInfoFromSavedPersona
from EntityExtractorOpenAI import generate_entities
from fastapi.middleware.cors import CORSMiddleware
from deta import Deta
from typing import Union
from pydantic import BaseModel
#from dotenv import load_dotenv
import os
import json
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
    location: Union[str,None]
    education: Union[str, None] 
    income: Union[str, None] 
    music_interest: Union[list[str], None] 
    book_interest: Union[list[str], None] 
    movies_interest: Union[list[str], None] 
    sport_interest: Union[list[str], None] 
    hobby: Union[list[str], None] 
    class Config:
        orm_mode = True

@app.get("/")
def search_with_string(input :str):    
    print("received input is:", input)
    print("Triggering generate entities")
    entities = generate_entities(input)
    print("Triggering generate entities is done. Result: ", entities)

    print("Triggering extract information from text")
    queries = extractInfoFromTextV3(entities)
    print("Triggerin extract information from text is done: ", queries)

    print("Triggering findURLsByKeyword ")
    result = findURLsByKeyword(queries,limit=4)
    print("Triggering findURLsByKeyword is done. Result: ", result)

    return result


@app.post("/search-persona")
def search_with_persona(persona: Persona): 

    print("received persona is:", persona)
    print("Triggering extract information from persona")
    queries = extractInfoFromSavedPersona(json.loads(persona.json()))
    print("Triggerin extract information from persona is done: ", queries)

    print("Triggering findURLsByKeyword ")
    result = findURLsByKeyword(queries,limit=4)
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
        "location": item.location,
        "marital_status": item.marital_status,
        "education": item.education,
        "income": item.income,
        "music_interest": item.music_interest,
        "book_interest": item.book_interest,
        "movies_interest": item.movies_interest,
        "sport_interest": item.sport_interest,
        "hobby": item.hobby
    })

    return user

@app.get("/users/{access_id}")
def get_user(access_id):
    
    personas = db.fetch({"access_id" : access_id})
    print(personas)
    if personas.count != 0:
        return personas.items
    #access_id is not used before
    return []



#@app.put("/users/<key>")
#def update_user(key):
#    user = db.put(request.json, key)
#    return user

@app.delete("/users/{access_id}/{name}")
async def delete_user(access_id,name):
    try:
        persona = db.fetch({"access_id" : access_id, "name": name})
        db.delete(persona.items[0]["key"])
        return persona.items[0]["name"]
    except:
        raise HTTPException(status_code=404, detail = f"There is no persona for access_id: '{access_id}' name: '{name}'")
    
