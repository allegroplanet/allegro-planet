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