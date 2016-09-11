module RoomMembers
  class JoinGuestService < BaseService
    def initialize(player_params, room_member_params, player_character_params, player_character_class_set_params, room_id)
      @player_params = player_params.dup
      @room_member_params = room_member_params.dup
      @player_character_params = player_character_params.dup
      @player_character_class_set_params = player_character_class_set_params.dup
      @room_id = room_id
    end

    def execute
      player = Player.new(@player_params)
      player.is_guest_user = true
      player.save
      player_character = PlayerCharacter.new(@player_character_params)
      player_character.rooms = Room.find([@room_id])
      player_character.player = player
      player_character.save
      player_character_class_set = PlayerCharacterClassSet.new(@player_character_class_set_params)
      player_character_class_set.name = "guest_class_set"
      player_character.player_character_class_sets << player_character_class_set 
      room_member = RoomMember.find_by_player_character_id(player_character.id)
      room_member.acceptable_party_leader = @room_member_params["acceptable_party_leader"]
      room_member.acceptable_room_leader = @room_member_params["acceptable_room_leader"]
      room_member.player_character = player_character
      room_member.save
      room_member
    end
  end
end
