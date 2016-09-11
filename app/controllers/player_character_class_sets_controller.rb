class PlayerCharacterClassSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user_must_be_create_player!

  def new
    @player_character_class_set = PlayerCharacterClassSet.new
  end

  def create
    player_character = current_user.player.player_characters.find(params[:player_character_id])
    @player_character_class_set = ::PlayerCharacterClassSets::CreateService.new(player_character_class_set_params, player_character).execute
    if @player_character_class_set.saved?
      redirect_to player_path(@player_character_class_set.player_character.player), notice: "'#{@player_character_class_set.name}' を登録しました。"
    else
      render 'new'
    end
  end

  def edit
    @player_character_class_set = find_auth_player_chracter_class_set(params[:player_character_id], params[:id])
  end

  def update
    player_character_class_set = find_auth_player_chracter_class_set(params[:player_character_id], params[:id])
    status = ::PlayerCharacterClassSets::UpdateService.new(player_character_class_set, player_character_class_set_params).execute
    if status
      redirect_to player_path(player_character_class_set.player_character.player), notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  def destroy
    find_auth_player_chracter_class_set(params[:player_character_id], params[:id]).destroy
    redirect_to player_path(current_user.player)
  end

  def index_ajax
    render json: current_user.player.player_characters.find(params[:player_character_id]).player_character_class_sets.select(:id, :name, :main_class, :sub_class)
  end

  private

  def player_character_class_set_params
    params.require(:player_character_class_set).permit(:name, :main_class, :sub_class, :skill_tree, :weapon)
  end

  def find_auth_player_chracter_class_set(character_id, class_set_id)
    current_user.player.player_characters.find(character_id).player_character_class_sets.find(class_set_id)
  end

end
