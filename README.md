# Viewing Party



### About

Viewing party is an application for users to explore movies via The Movie Database API and create viewing parties. Users can host their own parties and invite their friends on the app or attend parties hosted by other users.

[👀 Visit the app on Heroku](https://git.heroku.com/rocky-retreat-38535.git)

<!-- test coverage -->
<!-- Travis CI badge -->

## Local Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:create`
4. Run migrations: ` rails db:migrate`
4. Install the Figaro gem: `bundle exec figaro install`
5. Create an account with [The Movie Database](https://www.themoviedb.org/signup) and request an API key
6. Add your API key to the `application.yml` created by Figaro: 
  ```rb
  MOVIE_DB_KEY: your_api_key
  ```

## Using the App

### Database Design

<img width="400" alt="database schema diagram" src="https://user-images.githubusercontent.com/26797256/125482889-0357bbc1-45e7-4018-829e-cebfdc18d446.png">

### Tools and Dependencies

#### G
#### Testing




<!-- explain how to run tests (`bundle exec rspec`) -->

## Versions

- Ruby 2.7.2

- Rails 5.2.5

<!-- screenshots of final app -->
Example wireframes to follow are found [here](https://backend.turing.io/module3/projects/viewing_party/wireframes)

## Maintainers/Teammates

<!-- info about and links to our github/linkedins etc. -->

## Authors

- Molly Krumholz - mkrumholz
- Emmy Morris - 
