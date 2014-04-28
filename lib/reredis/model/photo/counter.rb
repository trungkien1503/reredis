module Reredis
  module Model
    module Photo
      module Counter
        def pins_count
          unless value=self.get_redis(:pins_count)
            value = self.pins.count
            self.set_redis :pins_count, value 
          end
          value.to_i
        end

        def likes_count
          unless value=self.get_redis(:likes_count)
            value = self.likes.count
            self.set_redis :likes_count, value
          end
          value.to_i
        end

        def comments_count
          unless value=self.get_redis(:comments_count)
            value = self.comments.count
            self.set_redis :comments_count, value 
          end
          value.to_i
        end

        def reports_count
          unless value=self.get_redis(:reports_count)
            value = ReportPhoto.where(photo_id: self.id).count
            self.set_redis :reports_count, value 
          end
          value.to_i
        end

        def remove_keys_after_delete_photo
          $redis.del self.redis_key(:pins_count)
          $redis.del self.redis_key(:likes_count)
          $redis.del self.redis_key(:comments_count)
          $redis.del self.redis_key(:reports_count)
        end

        def get_redis(key)
          begin
            $redis.get self.redis_key(key)
          rescue => e
            Rails.logger.error "Redis server error: #{e.message}"
            case key.to_s.split(":").last
              when "pins_count"
                self.pins.count
              when "likes_count"
                self.likes.count
              when "comments_count"
                self.comments.count
              when "reports_count"
                ReportPhoto.where(photo_id: self.id).count
            end
          end
        end
      end
    end
  end
end