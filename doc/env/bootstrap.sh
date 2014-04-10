#!/bin/bash

sudo apt-get update -q -y

sudo apt-get -y -q install gawk libgdbm-dev pkg-config libffi-dev build-essential openssl libreadline6 libreadline6-dev curl git zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion python postgresql postgresql-contrib libpq-dev redis-server python-software-properties

su -l vagrant -c "curl -L https://get.rvm.io | bash -s stable"
su -l vagrant -c "source \"/home/vagrant/.rvm/scripts/rvm\""
su -l vagrant -c "rvm install ruby-2.1.0"
su -l vagrant -c "gem install bundler"

sudo -u postgres psql -U postgres -d postgres -c "CREATE USER base_app WITH PASSWORD 'password1' CREATEDB;"
