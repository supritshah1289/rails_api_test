FROM ruby:2.6.3
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

#exposing port so it's accessible outside 
EXPOSE 3000


# ENTRYPOINT ['./application/entrypoint.sh']
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]