curl:
  pkg:
    - installed

ruby1.9.1-dev:
  pkg:
    - installed

gawk:
  pkg:
    - installed

libgdbm-dev:
  pkg:
    - installed

pkg-config:
  pkg:
    - installed

libffi-dev:
  pkg:
    - installed

openssl:
  pkg:
    - installed

libreadline6:
  pkg:
    - installed

libreadline6-dev:
  pkg:
    - installed

zlib1g:
  pkg:
    - installed

zlib1g-dev:
  pkg:
    - installed

libssl-dev:
  pkg:
    - installed

libyaml-dev:
  pkg:
    - installed

libsqlite3-dev:
  pkg:
    - installed

sqlite3:
  pkg:
    - installed

libxml2-dev:
  pkg:
    - installed

libxslt1-dev:
  pkg:
    - installed

autoconf:
  pkg:
    - installed

libc6-dev:
  pkg:
    - installed

libncurses5-dev:
  pkg:
    - installed

automake:
  pkg:
    - installed

libtool:
  pkg:
    - installed

bison:
  pkg:
    - installed

subversion:
  pkg:
    - installed

python:
  pkg:
    - installed

python-software-properties:
  pkg:
    - installed

rvm:
  cmd:
    - run
    - name: curl -L get.rvm.io | bash -s stable
    - user: vagrant
    - unless: test -s "$HOME/.rvm/scripts/rvm"
    - require:
      - pkg: curl

rvm_bashrc:
  cmd:
    - run
    - name: echo "[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm" >> $HOME/.bashrc
    - user: vagrant
    - unless: grep ".rvm/scripts/rvm" ~/.bashrc
    - require:
      - cmd: rvm

ruby:
  cmd:
    - run
    - name: rvm install 2.1.4
    - user: vagrant
    - unless: test -d $HOME/.rvm/rubies/2.1.4
    - require:
      - cmd: rvm_bashrc
