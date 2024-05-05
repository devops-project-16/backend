Follow the instructions to setup, and run the application.
1) Clone the frontend github repository from root.
```
git clone https://github.com/devops-project-16/frontend
```
2) Create a virtual enviorment, and activate it
```
python -m venv .venv
.venv\Scripts\Activate.ps1 (powershell)
```
3) Install the necessary dependencies.
```
pip install -r requirements.txt
```
4) Test the application.
```
pytest
```
5) Run the application.
```
fastapi dev main.py
```
