class RoomCommentsController < ApplicationController

  def create
    @room_comment = ::RoomComments::CreateService.new(room_comment_params, Room.where(uuid: params[:room_uuid]).first.id).execute
    if @room_comment.saved?
      redirect_to room_path(params[:room_uuid]), notice: "コメントを書き込みました"
    else
      redirect_to room_path(params[:room_uuid]), notice: "コメントを書き込めませんでした" 
    end
  end

  def room_comment_params
    params.require(:room_comment).permit(:name, :comment)
  end

end
