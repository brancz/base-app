#!/bin/bash

sudo apt-get update -q -y

sudo apt-get -y -q install gawk libgdbm-dev pkg-config libffi-dev build-essential openssl libreadline6 libreadline6-dev curl git zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion python postgresql postgresql-contrib libpq-dev redis-server python-software-properties

sudo apt-add-repository -y ppa:chris-lea/node.js
sudo apt-get update -q -y
sudo apt-get install nodejs -q -y
sudo apt-get install npm -q -y
sudo npm install -g karma
sudo ln -s /usr/bin/nodejs /usr/bin/node &>/dev/null

su -l vagrant -c "curl -L https://get.rvm.io | bash -s stable --rails"
su -l vagrant -c "source \"/home/vagrant/.rvm/scripts/rvm\""
