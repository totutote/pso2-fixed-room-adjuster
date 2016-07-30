class RoomMembersController < ApplicationController

  def create
    @room_member = ::RoomMembers::JoinGuestService.new(guest_player_params, room_member_params, player_character_params, Room.where(uuid: params[:room_uuid]).first.id).execute
    if @room_member.saved?
      redirect_to room_path(params[:room_uuid]), notice: "'#{@room_member.room.name}'に参加登録しました。"
    else
      redirect_to room_path(params[:room_uuid]), notice: "'#{@room_member.room.name}'に参加失敗しました。" 
    end
  end

  def edit
    @room_member = RoomMember.where(id: params[:id]).first
    @player_character = @room_member.player_character
    @player_character ||= PlayerCharacter.new
  end

  def update
    status = ::RoomMembers::UpdateService.new(guest_player_params, room_member_params, player_character_params, RoomMember.find(params[:id])).execute
    if status
      redirect_to room_path(params[:room_uuid]), notice: "編集しました。"
    else
      render 'edit'
    end 
  end

  def destroy
    RoomMember.destroy(params[:id])
    redirect_to room_path(params[:room_uuid])
  end

  def organize
    status = ::RoomMembers::OrganizeService.new(Room.where(uuid: params[:room_uuid]).first).execute
    if status
      redirect_to room_path(params[:room_uuid]), notice: "編成しました。"
    else
      redirect_to room_path(params[:room_uuid]), notice: "編成できませんでした。"
    end
  end

  def reset_organize
    room = Room.where(uuid: params[:room_uuid]).first
    room.room_members.update(room_number: nil, party_number: nil, is_room_leader: nil, is_party_leader: nil)
    redirect_to room_path(params[:room_uuid]), notice: "リセットしました。"
  end

  private

  def guest_player_params
    params.require(:player).permit(:player_id_name)
  end

  def room_member_params
    params.require(:room_member).permit(:acceptable_room_leader, :acceptable_party_leader)
  end

  def player_character_params
    params.require(:player_character).permit(:name, :main_class, :sub_class)
  end

end
