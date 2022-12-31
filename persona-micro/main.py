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
    machine_id :  Union[str, None] 
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
def search_with_persona(machine_id,name):    
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


@app.post('/users')
def create_user(item: Persona):

    user = db.put({
        "machine_id": item.machine_id,
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

@app.get("/users/{machine_id}/{name}")
def get_user(machine_id,name):
    
    personas = db.fetch({"machine_id" : machine_id, "name": name})
    print(personas)
    if personas.count != 0:
        return personas 
    raise HTTPException(status_code=404, detail = f"There is no persona for machine_id: '{machine_id}' name: '{name}'")



#@app.put("/users/<key>")
#def update_user(key):
#    user = db.put(request.json, key)
#    return user

@app.delete("/users/{machine_id}/{name}")
def delete_user(machine_id,name):
    persona = db.fetch({"machine_id" : machine_id, "name": name})
    if persona is not None:
        db.delete(persona.get)
        return {"status": "ok"}
    
    raise HTTPException(status_code=404, detail = f"There is no persona for machine_id: '{machine_id}' name: '{name}'")









    




