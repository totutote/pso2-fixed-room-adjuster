class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user_must_be_create_player!

  def authenticate_user_must_be_create_player!
    return unless user_signed_in?
    player = current_user.player
    if player.nil?
      redirect_to new_player_path 
      return
    end
    redirect_to new_player_character_path unless player.player_characters.first
  end

end
