# README

## Requirements
1. docker
1. docker-compose

## Install

1. docker-compose up -d muh_rails_server
1. docker-compose exec muh_rails_server rake db:create db:migrate db:seed
1. docker-compose exec muh_rails_server rspec
1. access http://localhost:3000

