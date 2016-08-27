class PlayersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_user_must_be_create_player!, except: [:new, :create]

  def new
    redirect_to root_path if current_user.player
    @player = Player.new
  end

  def create
    @player = ::Players::CreateService.new(player_params, current_user).execute
    if @player.saved?
      redirect_to player_path(@player), notice: "'#{@player.player_id_name}' を作成しました。"
    else
      render 'new'
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
    @player = current_user.player
  end

  def update
    status = ::Players::UpdateService.new(current_user.player, player_params).execute
    if status
      redirect_to player_path(current_user.player), notice: "編集しました。"
    else
      redirect_to edit_player_path(current_user.player), notice: "入力に誤りがあります。"
    end 
  end

  private

  def player_params
    params.require(:player).permit(:player_id_name)
  end

end
