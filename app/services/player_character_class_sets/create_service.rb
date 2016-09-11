module PlayerCharacterClassSets
  class CreateService < BaseService
    def initialize(params, player_character)
      @params = params.dup
      @player_character = player_character
    end

    def execute
      player_character_class_set = PlayerCharacterClassSet.new(@params)
      @player_character.player_character_class_sets << player_character_class_set
      return player_character_class_set
    end
  end
end
