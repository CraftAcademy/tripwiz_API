# TripWiz API

[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/tripwiz_API/badge.svg?branch=development)](https://coveralls.io/github/CraftAcademy/tripwiz_API?branch=development)

TripWiz is a trip planner, mainly for city get-aways, where a suggested itinerary is provided to you based on a few of your preferences. User authentication is through facebook login, and the client interface is built on React with redux, while the backend is Rails with various google and amedeus API's attached.

## Deployed Site
https://tripwiz.netlify.com/

## Dependencies
- Ruby 2.5.1
- Rails 6.0.2
- rest-client
- rack-cors
- devise_token_auth
- amadeus
- omniauth-facebook

## To run locally
#### Clone repository
```
$ git clone https://github.com/CraftAcademy/the_reactive_herald_API.git
```
```
$ cd tripwiz_API
```

#### Install dependencies
Install Rspec and dependencies
```
$ bundle
```

## Run testing frameworks
In console:
Run Rspec 
```
$ rspec
```

## Actions available to the user

Head to the deployed address listed above, or your local host with frontend running, and have a look around.

## Updates/Improvement plans
- Monetization through subscriptions and Stripe payments
- Your trips saved to your account
- Suggestions for most booked destinations
- Hotel and flight booking through amadeus

## License
Created under the <a href="https://en.wikipedia.org/wiki/MIT_License">MIT License</a>.
