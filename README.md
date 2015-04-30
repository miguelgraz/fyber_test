# Fyber Client
This project is a tiny web app that consumes the [offer API](http://developer.fyber.com/content/ios/offer-wall/offer-api/), it aims to receive three custom parameters and, along with other predefined parameters, to request available options and render a bit of info of each one.

## Development decisions
Since the requirements were simple I aimed to also keep the app small, therefore Sinatra was the choice over, for example, Rails. It ended up being only 3 routes and one helper method to calculate the hashkey.  
Even though I wouldn't like to add other test framework I believe RSpec allows us to have tests much easier to read so this dependency was accepted.  
As you can see the project doesn't have any design on its views since its main objective was to hit the API and handle the response.

## Setting up and running specs
It was designed to run on Heroku so our frontdoor to run it locally is the `config.ru` file. Just follow the steps:
- `git clone` this repository
- `cd` the folder
- `bundle` to install dependencies
- `rackup -p 4567` and the app should be running on http://localhost:4567

or simply go to https://fyber-test.herokuapp.com/

To run the specs you can either run `rspec` or `rake` being on the app's folder.
