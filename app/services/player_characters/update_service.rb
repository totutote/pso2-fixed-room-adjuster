module PlayerCharacters
  class UpdateService < BaseService
    def initialize(player_character, params)
      @player_character = player_character
      @params = params.dup
    end

    def execute
      return false if @params[:name].empty?
      @player_character.update(@params)
      @player_character.save
    end
  end

end
