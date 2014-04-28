module Reredis
  module Model
    module RedisObject
      def redis_key(str)
        "#{self.class.base_class.name.downcase}:#{self.id}:#{str}"
      end

      def set_redis(key,value)
        begin
          $redis.set redis_key(key),value
        rescue => e
          Rails.logger.error "Redis server error when set #{redis_key(key)}: #{e.message}"
        end
      end

      def get_redis(key)
        begin
          $redis.get redis_key(key)
        rescue => e
          Rails.logger.error "Redis server error: #{e.message}"
        end
      end

      def incr_counter(key)
        begin
          key_redis = redis_key(key)
          $redis.exists(key_redis) ? $redis.incr(key_redis) : self.send(key)
        rescue => e
          Rails.logger.error "Redis server error when incr #{key_redis}: #{e.message}"
        end
      end

      def decr_counter(key)
        begin
          key_redis = redis_key(key)
          $redis.exists(key_redis) ? $redis.decr(key_redis) : self.send(key)
        rescue => e
          Rails.logger.error "Redis server error when decr #{key_redis}: #{e.message}"
        end
      end
    end
  end
end