# Ce fichier build et host un site Jekyll dans le dossier racine du Dockerfile
# NOTE: pour rouler sur localhost: sudo docker build . --network="host"

FROM jekyll/jekyll

RUN apt-get install curl
RUN apt-get install wget