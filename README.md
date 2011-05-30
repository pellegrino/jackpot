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
        bundle install

For using jackpot at this current version, its necessary to run this
rack application using passenger or other rack based web server. In
development, its okay to use Webrick with the following command

        bundle exec jackpot server

The client, simulating an rack based app, accessing Jackpots web
server, in this version should be initialized in a separate shell
using the following command

        bundle exec jackpot client

That will give auto completion support and initialize the client
pointing to a jackpot instance running in localhost:4567

Currently the following methods are supported at the API:

* Basic subscription management
  * Jackpot::Subscription.list
  * Jackpot::Subscription.get(id)
  * Jackpot::Subscription.create(subscription)
  * Jackpot::Subscription.destroy(id)
  * Jackpot::Subscription.update(id, subscription)

## Added in second iteration of RMU
* Basic customer management
  * Jackpot::Customer

* Payment support (using Active Merchant)
  * Jackpot::Payment
  * Supports one time payments
  * Supports recurring payments

## Added in third iteration of RMU

* Refine jackpot's configuration
* Initializer to configure Jackpot payment gateway and its client accordingly
* Using Jackpot adapters for payment

## Later development (Post RMU)

* Provide more examples of gateway adapters
* Improve Gateway's API
  * Cancel subscriptions
  * Credit card storage and such
  * Support non credit card payments such as "Bank Slip"


### Jackpot configuration file ###
A config/jackpot.yml file is required. Check an example at
config/jackpot.yml.example

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

