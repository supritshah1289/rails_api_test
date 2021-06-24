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

`

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
`

- add credentails using the command
  `EDITOR="code --wait" rails credentials:edit`
  It will open a file in default editor, update the file by adding access id and key

- Update configuration for storage in file
  File -> config/environments/development.rb
  Update -> config.active_storage.service = :amazon

File -> config/storage.yml
Update ->
amazon:
service: S3
access_key_id: ""
secret_access_key: ""
bucket: ""
region: "" # e.g. 'us-east-1'
