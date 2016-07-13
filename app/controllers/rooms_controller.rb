class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order(quest_start_time: :desc)
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

  def show
    @room = Room.find(params[:id])
    @player = Player.new
    @room_member = RoomMember.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    status = ::Rooms::UpdateService.new(Room.find(params[:id]), room_params).execute
    if status
      redirect_to :action => "show", notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  def destroy
    rooms = RoomMember.where(room_id: [params[:id]])
    rooms.each do |room|
      room.player.destroy if room.player.is_guest_user
    end
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  def shorturl
    require 'google/apis/urlshortener_v1'
    service = Google::Apis::UrlshortenerV1::UrlshortenerService.new
    service.key = ENV['GOOGLE_API_KEY']
    url_object = Google::Apis::UrlshortenerV1::Url.new
    
    url_object.long_url = request.protocol + request.raw_host_with_port + "/rooms/#{params[:id]}"
    response = service.insert_url(url_object)
    Room.find(params[:id]).update(short_url: response.id)
    redirect_to(:back)
  end

  private

  def room_params
    params.require(:room).permit(:name, :room_pass, :min_player, :max_player,
                                 :block_no, :block_place, :recruitment_deadline,
                                 :meeting_time, :quest_start_time, :quest_end_time,
                                 :description)
  end
end
