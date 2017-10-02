# README
[![CircleCI](https://circleci.com/gh/jtrudell/angry_transit_tracker/tree/master.svg?style=shield)](https://circleci.com/gh/jtrudell/angry_transit_tracker/tree/master)

This is the Angry CTA Bus Tracker. To get it up and running:

* Dependencies: You will need Postgres, Ruby, bundler (gem install bundler) and npm.

To install dependences:
```bundle install && npm install```

* Configuration: You will need your own API key for the CTA bus tracker. Create a .env file in the root of the project, and include your API key:
```CTA_API_KEY = "YOUR KEY HERE"```

* Database: We use postgres. Note that you will not be able to seed the database without a CTA API key (see above)
```rails db:create && rails db:migrate && rails db:seed```

* Start the server on localhost 3000. You will need foreman (gem install foreman) if you don't already have it.
```foreman start -f Procfile.dev -p 3000```

* Run the tests
```rails test```
