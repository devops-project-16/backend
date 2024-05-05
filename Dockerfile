# Define base image
FROM python:3.10-slim-buster

# Update ubuntu packages
RUN apt-get update && apt-get upgrade -y

# Set this folder as the working dir, but if it doesn't exist then create it inside the docker image
# Thus the CMD will be run from this dir
WORKDIR /app

# Copies all files from cd to the image 
COPY . /app

# Update pip
RUN pip install --no-cache-dir --upgrade pip

# Install requirements
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# exposes port 8000 of the virtual machine running this docker image
EXPOSE 8000

#The command and arguments that run whenever the container is started 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]