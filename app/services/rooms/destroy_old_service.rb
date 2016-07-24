module Rooms
  class DestroyOldService < BaseService
    def initialize(keep_days)
      @keep_days = keep_days
    end

    def execute
      rooms = Room.where("created_at < ?", (Time.zone.now - @keep_days.days))
      rooms.each do |room|
        room.destroy
      end
    end

  end
end
