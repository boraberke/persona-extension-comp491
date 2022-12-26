from fastapi import FastAPI, HTTPException
from WebCrawler import findURLsByKeyword, extractInfoFromTextV2
from EntityExtractorOpenAI import generate_entities
from fastapi.middleware.cors import CORSMiddleware
from deta import Deta
from typing import Union
from pydantic import BaseModel
import os

app = FastAPI(
    title="WebTrackApp",
    version="0.0.1",
)


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
    interest: Union[str, None] 


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
        "interest": item.interest,
    })

    return user["key"]

@app.get("/users/{key}")
def get_user(key):
    
    personas = db.fetch({"machine_id" : key})
    print(personas)
    if personas.count != 0:
        return personas 
    raise HTTPException(status_code=404, detail = f"There is no persona for '{key}'")



#@app.put("/users/<key>")
#def update_user(key):
#    user = db.put(request.json, key)
#    return user

@app.delete("/users/{key}")
def delete_user(key):
    db.delete(key)
    return {"status": "ok"}
    








    




