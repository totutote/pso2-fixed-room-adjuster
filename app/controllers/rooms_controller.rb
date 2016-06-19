class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = ::Rooms::CreateService.new(room_params).execute
    if @room.saved?
      redirect_to :action => "index", notice: "'#{@room.name}' を作成しました。"
    else
      render 'new' 
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to :action => "index"
  end

  private

  def room_params
    params.require(:room).permit(:name, :room_pass, :min_player, :max_player,
                                 :block_no, :block_place, :recruitment_deadline,
                                 :meeting_time, :quest_start_time, :quest_end_time)
  end
end
