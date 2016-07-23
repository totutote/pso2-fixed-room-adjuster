class RoomsController < ApplicationController
  before_action :destroy_old_rooms, only: :create  

  KEEP_OLD_ROOM_DAYS = 7
  
  def index
    @rooms = Room.where.not(is_hidden_page: true).order(quest_start_time: :desc)
  end

  def new
    @room = Room.new
    @room.group_uuid = params[:group_uuid] if params[:group_uuid]
    @keep_old_room_days = KEEP_OLD_ROOM_DAYS
  end

  def destroy_old_rooms
    ::Rooms::DestroyOldService.new(KEEP_OLD_ROOM_DAYS).execute
  end

  def create
    @room = ::Rooms::CreateService.new(room_params).execute
    if @room.saved?
      redirect_to room_path(@room.uuid), notice: "'#{@room.name}' を作成しました。"
    else
      p @room.errors
      render 'new'
    end
  end

  def show
    @room = Room.where(uuid: params[:uuid]).first
    @player = Player.new
    @room_member = RoomMember.new
    @page_url = page_url
  end

  def edit
    @room = Room.where(uuid: params[:uuid]).first
  end

  def update
    status = ::Rooms::UpdateService.new(Room.where(uuid: params[:uuid]), room_params).execute
    if status
      redirect_to :action => "show", notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  def destroy
    room_id = Room.where(uuid: params[:uuid]).first.id
    room_members = RoomMember.where(room_id: room_id)
    room_members.each do |room_member|
      room_member.player.destroy if room_member.player.is_guest_user
    end
    Room.destroy(room_id)
    redirect_to rooms_path
  end

  def shorturl
    require 'google/apis/urlshortener_v1'
    service = Google::Apis::UrlshortenerV1::UrlshortenerService.new
    service.key = ENV['GOOGLE_API_KEY']
    url_object = Google::Apis::UrlshortenerV1::Url.new
    
    url_object.long_url = page_url
    response = service.insert_url(url_object)
    Room.where(uuid: params[:uuid]).first.update(short_url: response.id)
    redirect_to(:back)
  end

  private

  def room_params
    params.require(:room).permit(:name, :ship_number, :room_pass, :min_player, :max_player,
                                 :block_no, :block_place, :recruitment_deadline,
                                 :meeting_time, :quest_start_time, :quest_end_time,
                                 :is_hidden_page, :description, :group_uuid)
  end

  def page_url
    request.protocol + request.raw_host_with_port + "/rooms/#{params[:uuid]}"
  end
end
