module Reredis
  module Model
    module User
      module Counter   
        def photos_count
          unless value=self.get_redis(:photos_count)
            value = self.photos.real.count
            self.set_redis :photos_count, value
          end
          value.to_i
        end

        def pins_count
          unless value=self.get_redis(:pins_count)
            value = self.pins.count
            self.set_redis :pins_count, value
          end
          value.to_i
        end

        def get_redis(key)
          begin
            $redis.get redis_key(key)
          rescue => e
            Rails.logger.error "Redis server error: #{e.message}"
            case key.to_s.split(":").last
              when "pins"
                self.pins.to_a.each_with_object({}){ |p,h| h[p.pinnable_id] = true }.to_json
              when "likes"
                self.likes.to_a.each_with_object({}){ |p,h| h[p.photo_id] = true }.to_json
              when "followers"
                self.followers.to_a.each_with_object({}){ |p,h| h[p.id] = true }.to_json
              when "photos_count"
                self.photos.real.count
              when "pins_count"
                self.pins.count
            end
          end
        end
      end
    end
  end
end