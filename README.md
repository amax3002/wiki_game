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

### Application Development:

Built with

1. [Vis.js](http://visjs.org): A dynamic, browser based visualization library built with Javascript. I used the Network graph. This was particularly challenging because it required me to return JSON into an ajax call. Two things I have never done before.
2. [Nokogiri](http://www.nokogiri.org/): Nokogiri is an HTML, XML, SAX, and Reader parser. Among Nokogiri's features is the ability to search documents via XPath or CSS3 selectors. I used this to parse through HTML data by removing tags, searching only the "#content" part of the HTML page, or gathering all the links on a page to use to prevent cheating.
3. [HTTParty](https://github.com/jnunemaker/httparty): HTTParty is a gem that, at its simplest, allows use of a "get" method that can retrieve data over HTTP. I used this with Nokogiri to help cleanly get, parse, and reformat HTML inputs.

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
