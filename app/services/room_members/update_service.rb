module RoomMembers
  class UpdateService < BaseService
    def initialize(player_params, room_member_params, player_character_params, player_character_class_set_params, room_member)
      @player_params = player_params.dup
      @room_member_params = room_member_params.dup
      @player_character_params = player_character_params.dup
      @player_character_class_set_params = player_character_class_set_params.dup
      @room_member = room_member
    end

    def execute
      @room_member.acceptable_party_leader = @room_member_params["acceptable_party_leader"]
      @room_member.acceptable_room_leader = @room_member_params["acceptable_room_leader"]
      @room_member.player_character.player.player_id_name = @player_params["player_id_name"]
      if @room_member.player_character
        @room_member.player_character.update(@player_character_params)
        if @room_member.player_character.player_character_class_sets.first
          @room_member.player_character.player_character_class_sets.first.update(@player_character_class_set_params)
        else
          new_player_character_class_set
        end
      else
        player_character = PlayerCharacter.new(@player_character_params)
        @room_member.player_character = player_character
        new_player_character_class_set
      end
      @room_member.save
    end

    private

    def new_player_character_class_set
      player_character_class_set = PlayerCharacterClassSet.new(@player_character_class_set_params)
      @room_member.player_character.player_character_class_sets << player_character_class_set
    end
  end
end
