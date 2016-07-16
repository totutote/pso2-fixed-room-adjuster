class RoomMembersController < ApplicationController

  def create
    @room_member = ::RoomMembers::JoinGuestService.new(guest_player_params, room_member_params, Room.where(uuid: params[:room_uuid]).first.id).execute
    if @room_member.saved?
      redirect_to room_path(params[:room_uuid]), notice: "'#{@room_member.room.name}'に参加登録しました。"
    else
      redirect_to room_path(params[:room_uuid]), notice: "'#{@room_member.room.name}'に参加失敗しました。" 
    end
  end

  def destroy
    @room_member = RoomMember.find(params[:id])
    @room_member.destroy
    redirect_to room_path(params[:room_uuid])
  end

  private

  def guest_player_params
    params.require(:player).permit(:player_id_name)
  end

  def room_member_params
    params.require(:room_member).permit(:acceptable_room_leader, :acceptable_party_leader)
  end

end
