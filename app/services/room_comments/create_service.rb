module RoomComments
  class CreateService < BaseService
    def initialize(comment_params, room_id)
      @comment_params = comment_params.dup
      @room_id = room_id
    end

    def execute
      room_comment = RoomComment.new(@comment_params)
      room = Room.find(@room_id)
      room.room_comments << room_comment
      room_comment.save
      room_comment
    end
  end
end
