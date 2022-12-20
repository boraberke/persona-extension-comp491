import os
import openai
import json


#replace this with secret key from whatsapp
openai.api_key = os.getenv('OPEN_API_SECRET_KEY')


def generate_entities(text):
  search_text = "Give interests, nationality, gender, age and the name of the person as json that says : {input_text}".format(input_text = text)
  response = openai.Completion.create(
    model="text-davinci-003",
    prompt= search_text,
    temperature=0.6,
    max_tokens=150,
    top_p=1,
    frequency_penalty=1,
    presence_penalty=1
  )
  return json.loads(response["choices"][0]["text"].strip())



# add if __name__: