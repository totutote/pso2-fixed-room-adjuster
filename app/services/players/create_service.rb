module Players
  class CreateService < BaseService
    def initialize(params, user)
      @params = params.dup
      @user = user
    end

    def execute
      player = Player.find_by_user_id(@user.id)
      return player unless player.nil?
      @user.player = Player.new(@params)
      @user.player
    end

  end
end
