module PlayerCharacterClassSets
  class UpdateService < BaseService
    def initialize(player_character_class_set, params)
      @player_character_class_set = player_character_class_set
      @params = params.dup
    end

    def execute
      @player_character_class_set.update(@params)
      @player_character_class_set.save
    end
  end

end
