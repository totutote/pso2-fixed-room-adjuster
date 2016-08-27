class PlayerCharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_must_be_create_player!, except: [:new, :create]

  def new
    @player_character = PlayerCharacter.new
  end

  def create
    @player_character = ::PlayerCharacters::CreateService.new(player_character_params, current_user.player).execute
    if @player_character.saved?
      redirect_to player_path(@player_character.player.player_id_name), notice: "'#{@player_character.name}' を登録しました。"
    else
      render 'new'
    end
  end

  def edit
    @player_character = current_user.player.player_characters.find(params[:id])
  end

  def update
    player_character = current_user.player.player_characters.find(params[:id])
    status = ::PlayerCharacters::UpdateService.new(player_character, player_character_params).execute
    if status
      redirect_to player_path(player_character.player.player_id_name), notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  private

  def player_character_params
    params.require(:player_character).permit(:name, :ship_number)
  end

end
