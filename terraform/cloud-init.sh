#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose git

sudo usermod -aG docker adminuser

cd /home/adminuser
git clone https://github.com/Danielms111/microservice-app-example.git
cd microservice-app-example

sudo docker-compose -f docker-compose.dev.yml up --build
