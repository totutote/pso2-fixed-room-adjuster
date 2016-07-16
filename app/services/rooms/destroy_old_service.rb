module Rooms
  class DestroyOldService < BaseService
    def initialize(keep_days)
      @keep_days = keep_days
    end

    def execute
      rooms = Room.where("created_at < ?", (Time.zone.now - @keep_days.days))
      rooms.each do |room|
        room_members = RoomMember.where(room_id: room.id)
        room_members.each do |room_member|
          room_member.player.destroy if room_member.player.is_guest_user
        end 
        room.destroy
      end
    end

  end
end
