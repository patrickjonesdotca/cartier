# Cartier

    Cartier is a gem used to simplify some common GPS type calcuations from a current project I've been working on.

## Installation

Add this line to your application's Gemfile:

    gem 'cartier'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cartier

## Usage

    After installation one will need to create at minimum two instances of the Cartier::GPSLocation type.
    For example, the CN Tower location would be created as such: cn_tower = Cartier::GPSLocation.new("43.64775237227008", "-79.38707828521729")
    To determine the distance between two locations: Cartier::Navigation.haversine_distance(cn_tower, ago)
    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
