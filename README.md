Jackpot
==========

WORK IN PROGRESS/ Jackpot is the easiest way to get paid using ruby. It abstracts all the nasty details about billing that every Saas app have to deal with.

My May 2011 RMU project.

## Goals for the first prototype release ##

* Handle recurring payments
* Basic subscription management (CRUD operations)

## First iteration ##
* Created the jackspot gem, which is a consumer for the rack app which
supports basic subscription management

### How to use it ###
This application uses bundler and rvm for dependencies management, so its
recommended to create a gemset to test it.

Run the following commands at the directory where you've checked out
jackpot.

        rvm use 1.9.2@jackpot --create
        gem install bundler
        bundler install

For using jackpot at this current version, its necessary to run this
rack application using passenger or other rack based web server. In
development, its okay to use Webrick with the following command

        ruby jackpot_app.rb

The client, simulating an rack based app, accessing Jackpots web
server, in this version should be initialized in a separate shell
using the following command

        irb -r ./jackpot_client.rb -r irb/completion

That will give auto completion support and initialize the client
pointing to a jackpot instance running in localhost:4567

Currently the following methods are supported at the API:

* Basic subscription management
  * Jackpot::Subscription.list
  * Jackpot::Subscription.get(id)
  * Jackpot::Subscription.create(subscription)
  * Jackpot::Subscription.destroy(id)
  * Jackpot::Subscription.update(id, subscription)

For more information about usage, check tests/server/subscriptions_test.rb and tests/client/subscriptions_client_test.rb

### Jackpot configuration file ###
In this first iteration, only the database can (and needs to) be
configured. Jackpot check jackpot.yml for further details.

## For the next iteration ##
To be defined

## Contributing to jackpot  ##

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If
* you want to have your own version, or is otherwise necessary, that
* is fine, but please isolate to its own commit so I can cherry-pick
* around it.




## Copyright ##

Copyright (c) 2011 Vitor Pellegrino. See LICENSE.txt for
further details.

