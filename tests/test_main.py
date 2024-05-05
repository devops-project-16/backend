from fastapi.testclient import TestClient
from main import app

# Initialize test client
client = TestClient(app)

# Test case 1: Test if the projects endpoint returns a 200 status code
def test_projects_endpoint_status_code():
    response = client.get("/api/projects")
    assert response.status_code == 200

# Test case 2: Test if the education endpoint returns a JSON response
def test_education_endpoint_response():
    response = client.get("/api/education")
    assert response.headers["content-type"] == "application/json"

# Test case 3: Test if the certificates endpoint returns a list of certificates
def test_certificates_endpoint_response():
    response = client.get("/api/certificates")
    assert response.json() is not None

# Test case 4: Test if the work experience endpoint returns a JSON response
def test_work_experience_endpoint_response():
    response = client.get("/api/work-experience")
    assert response.headers["content-type"] == "application/json"

# Test case 5: Test if the projects endpoint returns valid project data
def test_projects_endpoint_data():
    response = client.get("/api/projects")
    projects = response.json()
    assert isinstance(projects, list)
    for project in projects:
        assert "title" in project
        assert "description" in project
        assert "start_date" in project
        assert "end_date" in project
