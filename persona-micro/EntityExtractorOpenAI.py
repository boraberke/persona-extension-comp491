import os
import openai
import json



#from dotenv import load_dotenv
#load_dotenv()

openai.api_key = os.getenv('OPEN_API_SECRET_KEY')


def generate_entities(text):
  
  search_text = "Give interests, nationality, gender, age and the name of the person as json that says : {input_text} without any command in string. If can't find a value for key set value to be unknown as string".format(input_text = text)
  print(search_text)
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt= search_text,
    temperature=0.6,
    max_tokens=150,
    top_p=1,
    frequency_penalty=1,
    presence_penalty=1
  )
  print("response",response["choices"][0]["text"])
    
  return json.loads(response["choices"][0]["text"].strip())

#text ="I am Emre a football player lives in London. I am interested in jazz."
#response = generate_entities(text)
#print(response)
#json_text = """{
#  "name": "Emre",
#  "nationality": "unknown",
#  "gender": "unknown",  
#  "age": "null",  
#  "interests": ["football","jazz"],  
#  "location":"London"   
#}"""
#print(json.loads(json_text))

# add if __name__: