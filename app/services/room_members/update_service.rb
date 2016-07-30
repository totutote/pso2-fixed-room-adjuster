module RoomMembers
  class UpdateService < BaseService
    def initialize(player_params, room_member_params, player_character_params, room_member)
      @player_params = player_params.dup
      @room_member_params = room_member_params.dup
      @player_character_params = player_character_params.dup
      @room_member = room_member
    end

    def execute
      @room_member.acceptable_party_leader = @room_member_params["acceptable_party_leader"]
      @room_member.acceptable_room_leader = @room_member_params["acceptable_room_leader"]
      @room_member.save
      @room_member.player.player_id_name = @player_params["player_id_name"]
      @room_member.player.save
      @room_member.player_character.update(@player_character_params)
    end
  end
end
