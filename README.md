# AllegroPlanet

## Setup guide for developers

### MacOS

Current installtation instructions are easiest with Homebrew.  You'll need to install ruby,

```
brew install ruby-install
ruby-install ruby 2.6.5
brew install chruby
```

This next step is important, you'll need to close and restart your terminal because
the newly available ruby version will not be seen by your terminal unless you do a
restart.  It's very annoying.

Once you have those dependencies in place, you can clone the repo and install
the app:

```
git clone https://github.com/allegroplanet/allegro-planet.git
cd allegro-planet
chruby 2.6.5
ruby -v
bundle install
```

Hopefully everything should pass with no error.  If you're having issues, you
can ask in the forums of [www.allegro.cc](https://www.allegro.cc/forums).

Once the app installed, you can start the server:

```
bin/rails server
```

And you should now be able to access your local version of the site at `http://localhost:3000`.





### Debian-Like Systems


Here is a list of prerequisites for developers on Debian-like systems:

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
