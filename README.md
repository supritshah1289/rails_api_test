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

## Commands to create this app

`rails new my_blog --api -d postgresql`

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

### Add GEMS

Run the command below
`bin/rails active_storage:install`

Below add to GEMFILE

`gem 'active_model_serializers', '~> 0.8.3'`
`gem "aws-sdk-s3", require: false`
