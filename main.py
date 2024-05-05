from fastapi import FastAPI
from typing import List, Dict
import json
from pydantic import BaseModel

app = FastAPI()

# Load JSON data
with open('db.json') as json_file:
    data = json.load(json_file)

# Define response models
class Item(BaseModel):
    title: str
    description: str
    start_date: str
    end_date: str

# Define endpoints
@app.get("/projects", response_model=List[Item])
async def get_projects():
    return data['projects']

@app.get("/education", response_model=List[Item])
async def get_education():
    return data['education']

@app.get("/certificates", response_model=List[Item])
async def get_certificates():
    return data['certificates']

@app.get("/work_experience", response_model=List[Item])
async def get_work_experience():
    return data['work_experience']
