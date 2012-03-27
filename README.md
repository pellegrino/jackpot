Jackpot
==========

# WORK IN PROGRESS

[![Build Status](https://secure.travis-ci.org/pellegrino/jackpot.png)](http://travis-ci.org/pellegrino/jackpot)
[![Dependency Status](https://gemnasium.com/pellegrino/jackpot.png)](https://gemnasium.com/pellegrino/jackpot)

_WORK IN PROGRESS_ 

Jackpot is the easiest way to get paid using ruby. It abstracts all the nasty details about billing that every Saas app have to deal with. It uses [Active Merchant](https://github.com/Shopify/active_merchant) internally, so Jackpot will suport the gateways (that support credit card storage) provided by Active Merchant, making it easier to extend to your own needs.
It is built using Rails Engines so it is easy to mount Jackpot in our rails 3.1 or 3.2 app and start using it to do your billing. 

It started out as my may 2011 session @ [Mendicant University](http://mendicantuniversity.org) project and now its going through a major overhaul to get ready to hit its primetime.  

## Installation

1. Add jackpot to your Gemfile as you normally would do with any bundler powered gem. You might also have to add jquery-rails as it is used extensively at jackpot.

        gem 'jackpot'
        gem 'jquery-rails'

1. Create an initializer to configure your gateway information. Heres an example of how to do it 

        Jackpot.configure do |c|
          if Rails.env.production? or Rails.env.staging?
            c.gateway_type      :braintree
            c.gateway_login     ENV['JACKPOT_LOGIN']
            c.gateway_password  ENV['JACKPOT_PASSWORD']
            c.gateway_mode      :test
          else
            c.gateway_type      :braintree
            c.gateway_login     'demo'
            c.gateway_password  'password'
            c.gateway_mode      :test
          end 
        end 
      
1. You should copy jackpot migrations to your project by issuing the following command

        bundle exec rake jackpot:install:migrations

1. Mount jackpot engine at your config/routes 
        
        mount Jackpot::Engine => "/billing"

After these steps, everything should be working. Don't forget to run your migrations so your database its updated

## How it works 

### Recurring Payments  

Even though some gateways will provide you a recurring payment option, normally it isn't a fire and forget process as you'ld normally imagine. Also, its needed to have information about when this payments actually did happen so you can send invoices accordingly. That being said, in Jackpot we opt to use Gateways that support credit card storage, instead of relying on Gateway Recurring payments. 

The main goal of this project is to provide billing to rails apps via a rails-engine. 

### List of supported gateways

Currently, only a small set of gateways is supported, however, it should be fairly simple to integrate any Active Merchant powered gateway that supports card storage

* Braintree
* Bogus (for testing)

### Cron job for Nightly billing 

You might also want to setup a cron job for running your billing periodically task. There is a jackpot:cron rake task provided. Edit your cron or similar to run that rake task as much as you want to. 

This task will bill automatically every customer that is currently overdue using his/hers saved credit card token information.


### Authentication

Jackpot uses devise internally to protect its controllers. 

You need to setup default url options for each environment you use. Heres an example for development environment.

      # in config/environments/development.rb
      config.action_mailer.default_url_options = { :host => 'localhost:3000' }
## Docs

This project uses YARD and the current can always be found at [http://rubydoc.info/github/pellegrino/jackpot](http://rubydoc.info/github/pellegrino/jackpot)

## Demo

There is a small rails 3.2 application to demonstrate how to use jackpot within a rails app. [http://github.com/pellegrino/jackpot-demo](jackpot-demo). Make sure to check this out to see how things are wired under the covers. 

## Contributing to jackpot

### How to run jackpot locally 
This application uses bundler and rvm for dependencies management, so its
recommended to create a gemset to test it.

Run the following commands at the directory where you've checked out
jackpot.

    rvm use 1.9.3@jackpot --create
    gem install bundler
    bundle install

### Migrations and RSpec 

Since this project is basically a Rails Engine, some additional steps are required to run the spec suite locally. Its a pretty straightfoward process, don't worry much about it. 

Before running the specs for the first time, or after adding a new migration, make sure to run the following command 

    bundle exec rake -f spec/dummy/Rakefile db:drop jackpot:install:migrations db:create db:migrate db:test:prepare

That will create and initialize the database for you. The dataase.yml file used is the one located at spec/dummy/config/database.yml. If you changed something that did require a migration to be created, make sure you've copied that one to spec/dummy/db/migrate folder.
   
    bundle exec rake -f spec/dummy/Rakefile jackpot:install:migrations 

The command above will copy every migration you created at Jackpot to the dummy app folder. Also, make sure to run the database initializer command above or your changes won't be reflected. 


### Rails development Server 

If you ran the migrations correctly, you can start the dummy app as you normally would start a regular Rails 3.x app.

    bundle exec rails server 

### Get in contact! 

There is a #jackpot channel @ freenode for this project. Feel free to stop by to ask questions and interact with other users. My IRC username is _pellegrino_ and i'm happy to help. 

## Copyright

Copyright (c) 2011-2012 Vitor Pellegrino. See MIT-LICENSE.txt for further details.

