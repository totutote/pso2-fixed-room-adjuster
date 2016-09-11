module PlayerCharacters
  class CreateService < BaseService
    def initialize(params, player)
      @params = params.dup
      @player = player
    end

    def execute
      return PlayerCharacter.new if @params[:name].empty?
      player_character = PlayerCharacter.new(@params)
      @player.player_characters << player_character
      return player_character
    end
  end

end
