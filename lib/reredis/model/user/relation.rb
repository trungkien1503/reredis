module Reredis
  module Model
    module User
      module Relation

        def get_pins_status
          unless self.get_redis(:pins)
            self.set_redis :pins, self.pins.to_a.each_with_object({}){ |p,h| h[p.pinnable_id] = true }.to_json
          end
          JSON.parse(self.get_redis(:pins))
        end

        def get_followers_status
          unless self.get_redis(:followers)
            self.set_redis :followers, self.followers.to_a.each_with_object({}){ |p,h| h[p.id] = true }.to_json
          end
          JSON.parse(self.get_redis(:followers))
        end

        def get_likes_status
          unless self.get_redis(:likes)
            self.set_redis :likes, self.likes.to_a.each_with_object({}){ |p,h| h[p.photo_id] = true }.to_json
          end
          JSON.parse(self.get_redis(:likes))
        end
        
      end
    end
  end
end   