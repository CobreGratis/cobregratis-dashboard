# Cobre Grátis Dashboard

## Setup Development Environment

1. Clone the repo

		$ git clone https://github.com/ddollar/heroku-config.git

1. Install [heroku-config](https://github.com/ddollar/heroku-config)

		$ heroku plugins:install git://github.com/ddollar/heroku-config.git

1. Pull the config variables

		$ heroku config:pull

1. Remove the CANONICAL_HOST variable from .env

		$ echo "`sed '/CANONICAL_HOST/d' .env`" > .env

1. Start the server

		$ foreman start

1. Open [http://localhost:5000](http://localhost:5000) in your browser

		$ open http://localhost:5000
