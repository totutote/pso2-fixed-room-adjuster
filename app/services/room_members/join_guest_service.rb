module RoomMembers
  class JoinGuestService < BaseService
    def initialize(player_params, room_member_params, room_id)
      @player_params = player_params.dup
      @room_member_params = room_member_params.dup
      @room_id = room_id
    end

    def execute
      @player = Player.new(@player_params)
      @player.is_guest_user = true
      @player.rooms = Room.find([@room_id])
      @player.save
      room_member = RoomMember.find_by_player_id(@player.id)
      room_member.acceptable_party_leader = @room_member_params["acceptable_party_leader"]
      room_member.acceptable_room_leader = @room_member_params["acceptable_room_leader"]
      room_member.save
      room_member
    end
  end
end
