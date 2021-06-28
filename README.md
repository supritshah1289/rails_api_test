# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Commands to create new rails app with postgresql database

`rails new my_blog --api -d postgresql`

## Command to run postgrest database docker container

```
docker run --name chumwander -d -p 5432:5432 -v <PATH TO YOUR LOCAL MACHINE>://var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres postgres:latest

```

# Step 1 Config > database.yml

    Add the configuration to development
    database: my_blog_development
    username: postgres
    password: postgres
    host: localhost
    port: 5432

## Generate models

`rails g scaffold user email:string password:string auth_token:string image:attachment`

`rails g scaffold post title:string body:text user:references image:attachment`

`rails g scaffold comment body:text user:references post:references`

After creating each models we need to migrate database using command `rake db:migrate`

### Add GEMS

Run the command below
`bin/rails active_storage:install`

Below add to GEMFILE

Serializing the api, all the models and dependencies
`gem 'active_model_serializers', '~> 0.8.3'`

Uploading images to S3 bucket
`gem "aws-sdk-s3", require: false`

# AWS S3 Config

- Create a bucket
- add permission on bucket

```
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "PUT",
            "POST",
            "DELETE"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": []
    }
]

```

- add credentails using the command
  `EDITOR="code --wait" rails credentials:edit`
  It will open a file in default editor, update the file by adding access id and key

- Update configuration for storage in file
  File -> config/environments/development.rb
  Update -> config.active_storage.service = :amazon

File -> config/storage.yml
Update ->

```
amazon:
service: S3
access_key_id: ""
secret_access_key: ""
bucket: ""
region: "" # e.g. 'us-east-1'

```

## Dockerize the application

Settings required for setting docker image

1. Database.yml
2. Dockerfile

Add Docker file

```
#Use the same ruby version from gemfile
FROM ruby:2.6
#copy application code into application directory
COPY . /application

#set configuration
RUN bundle config set --deployment "true"
RUN bundle config set --without "development test"

#Change to the application's directory
WORKDIR /application

RUN gem install bundler

# Install gems

RUN bundle install

#Set environment variable
ENV RAILS_ENV production

# ENTRYPOINT ['./application/entrypoint.sh']

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

```

Command to create an image of the application

`docker build . -t <NAME_OF_APPLICATION>`

Command to list all docker images

`docker images`

Command to run created docker image

`docker run -d -p 3000:3000 <CREATED_IMAGE>`

## Command to run the image created connects database container

```
docker run --name myblog -e DATABASE_HOST=172.17.0.1 -e DATABASE_PORT=5432 -e DATABASE_USERNAME=postgres -e DATABASE_PASSWORD=postgres -d -p 3000:3000 my_blog
```

Command to log in to running container
`docker exec -it <container_id> bash`

run command after login in to running docker container

## Pushing images to docker hub

It's a two steps process.

1. Create a tag of existing image with your docker hub login username
   `docker image tag my_blog supritshah1289/my_blog:v1`
2. push the image
   `docker image push supritshah1289/my_blog:v1`

# Docker Compose

1. Create docker compose file with dependencies
2. run the command to start compose ` docker-compose up` at the root of the docker compose file. The images has to be on docker hub to use in docker-compose.yml file
