module RoomMembers
  class JoinGuestService < BaseService
    def initialize(player_params, room_id)
      @player_params = player_params.dup
      @room_id = room_id
    end

    def execute
      @player = Player.new(@player_params)
      @player.is_guest_user = true
      @player.rooms = Room.find([@room_id])
      @player.save
      RoomMember.find_by_room_id(@room_id)
    end
  end
end
