# Brancusi [![Build Status](https://secure.travis-ci.org/jbrunton/brancusi.png)](http://travis-ci.org/jbrunton/brancusi)

An opinionated CoffeeScript framework for developing single page applications.

## Installation

Add these to your application's Gemfile:

    gem 'brancusi'
    gem 'brancusi-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brancusi
    $ gem install brancusi-rails

## Usage

Initialize your repository with the necessary application and configuration files:

    rails g brancusi:init

Create a controller (with corresponding template):

    rails g brancusi:controller home index
    
Add the necessary routing to ```app/assets/javascripts/app/config/routes.js.coffee```:

    @route '/', 'home#index'

Now start your Rails server!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
