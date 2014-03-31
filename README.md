[![Build Status](https://travis-ci.org/flower-pot/base-app.png?branch=master)](https://travis-ci.org/flower-pot/base-app)
[![Coverage Status](https://coveralls.io/repos/flower-pot/base-app/badge.png)](https://coveralls.io/r/flower-pot/base-app)

Deploy on Heroku
----------------

First create the config file, and edit it if needed.

	cp config/config.yml.example config/config.yml

Then add and commit it.

	git add -f config/config.yml
	git commit -m "heroku deploy time"

Heroku create and add the required addons.

	heroku create
	heroku addons:add redistogo:nano
	heroku addons:add heroku-postgresql:dev

Then deploy.

	git push heroku master
