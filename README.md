# Wikipedia Game

The Wikipedia Game is a game where the goal is to go from one random Wikipedia article page to another by only clicking available links. The framework creates a visual representation of the path taken by the user, and allows users to send challenges to friends. Users can track personal scores or compare their score to others.

Alexandre Guy built this application as his capstone project for the engineering bootcamp at Iron Yard, DC.

### Installation and Usage

The [Wikipedia Game](https://wikipediaframeworkgame.herokuapp.com/) is currently deployed to Heroku.

In order to run the application locally, you will need to have Postgres and PostGIS installed on your computer. The PostGIS installation is relatively straightforward. You can install it by running through the following commands, or for more in depth instructions please visit the github page for [activerecord-postgis-adaptor](https://github.com/rgeo/activerecord-postgis-adapter).

```
$ brew install postgis

$ bundle

$ rake db:gis:setup

$ rails db:migrate
```

You may then run ```$ rails s  ``` in order to start the application.

However, at this point you will have no data locally to work with.

### Known Issues and New Features

* There are a few links within the game that break. This links tend to be within Notes and/or References. There are also a few links that are from Wikipedias Help website.

* Better error handling if the link is bad.

* Color code VisJS nodes for start and end points (Move Path Graph).

* Allow the user to create a custom game.

### Testing

The project uses the standard rails ActiveSupport::TestCase for testing.

### Contributing

We would be more that happy to receive pull requests for bug fixes or new features! Please:

1. Fork this repo
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Submit a pull request!

### Acknowledgements

A big thank you to our fellow classmates at the Iron Yard, and our incredible instructors who answered countless questions and guided us through the course and the project.



Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
