# Reredis

Custorm redis gem

## Installation

Add this line to your application's Gemfile:

    gem 'reredis'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install reredis

## Usage
  A custorm gem redis- it include redis object and some sample counter for model : photo,user using Redis
  
  To use redis object 
  Add this line to your application's active record model
      $ include Reredis::Model::RedisObject

  To use User's counter and relation sample 
      $ include Reredis::Model::User::Counter
      $ include Reredis::Model::User::Relation

  To user Photo's counter sample
      $ include Reredis::Model::Photo::Counter

  You can test in rails console
      # Photo.first.likes_count
      # Photo.first.comments_count
      # Photo.first.pins_count
      # User.first.get_followers_status
      # User.first.get_likes_status

  Using method mget of Redis to get information

  Something like this :
      # @likes_count = Reredis.mget(photos, "likes_count")
      # @pins_count = Reredis.mget(photos, "pins_count")
      # @comments_count = Reredis.mget(photos, "comments_count") 




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
