from fastapi import FastAPI
from typing import List
import json
from pydantic import BaseModel
from fastapi.staticfiles import StaticFiles

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
@app.get("/api/projects", response_model=List[Item])
async def get_projects():
    return data['projects']

@app.get("/api/education", response_model=List[Item])
async def get_education():
    return data['education']

@app.get("/api/certificates", response_model=List[Item])
async def get_certificates():
    return data['certificates']

@app.get("/api/work-experience", response_model=List[Item])
async def get_work_experience():
    return data['work_experience']

app.mount("/", StaticFiles(directory="frontend", html=True), name="ui")
