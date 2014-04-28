$:.unshift('.')
$:.unshift(File.dirname(__FILE__))
$LOAD_PATH << 'lib'
require "rails"
require "redis"
require "reredis/model/redis_object"
require "reredis/version"
require "reredis/constant"
require "reredis/model/photo/counter"
require "reredis/model/user/counter"
require "reredis/model/user/relation"

module Reredis

  if Rails.env.production?
    $redis = Redis.new(:host => ENV['CACHE_REDIS'], :port => 6379)
    $redis_statistics = Redis.new(:host => ENV['CACHE_REDIS_TRACK_STATISTICS'], :port => 6379)
  elsif Rails.env.test?
    $redis = Redis.new(:host => ENV['CACHE_REDIS'], :port => 6379, :db => 1)
    $redis_statistics = Redis.new(:host => ENV['CACHE_REDIS_TRACK_STATISTICS'], :port => 6379, :db => 1)
  else
    $redis = Redis.new(:host => ENV['CACHE_REDIS'], :port => 6379, :db => 2)
    $redis_statistics = Redis.new(:host => ENV['CACHE_REDIS_TRACK_STATISTICS'], :port => 6379, :db => 2)
  end

  # if redis error or flushdb, please run rake redis:run_after_flushdb
  def self.mget(objects, str) 
    hash = Hash.new
    return hash if objects.blank?
    result = $redis.mget(self.generate_key_for_mget(objects, str))
    list_ids = objects.map(&:id)
    list_ids.each_index do |index|
      hash[list_ids[index].to_s] = result[index]
    end
    hash
  end

  def self.generate_key_for_mget(objects ,str)
    keys = Array.new
    objects.each do |ob|
      keys << "#{ob.class.base_class.name.downcase}:#{ob.id}:#{str}"
    end 
    keys
  end
end
