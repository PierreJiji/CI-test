# Ce fichier build et host un site Jekyll dans le dossier racine du Dockerfile
# NOTE: pour rouler sur localhost: sudo docker build . --network="host"

FROM ruby:3.0

WORKDIR /usr/src/app

RUN apt-get install git
RUN git clone "https://github.com/CQEN-QDCE/test-jekyll-pages.git" .

RUN gem install jekyll bundler
RUN bundle install
# cette librairie n'est pas présente dans ruby 3.0+ et dois être manuellement installée
RUN bundle add webrick 


# EXPOSE 4000
RUN bundle exec jekyll server