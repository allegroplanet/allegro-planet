# AllegroPlanet

Setup guide for developers
----

Here is a list of prerequisites 
for developers on Debian-like systems:

sudo apt install \
	sqlite3 \
	ruby \
	ruby-dev \
	nodejs \
	postgresql \
	libpq-dev

gem install rails

now go to your allegro-planet working copy, and run

bundle install
bin/rails server

You will also need to ensure postgresql is running on your machine so the app
can connect to it.
```
brew services start postgresql
```

The first time you are running in development, be sure to setup the database.
```
bin/rails db:setup
```
