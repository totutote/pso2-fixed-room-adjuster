module Players
  class UpdateService < BaseService
    def initialize(player, params)
      @player = player
      @params = params.dup
    end

    def execute
      @player.update(@params)
      @player.save
    end
  end

end
