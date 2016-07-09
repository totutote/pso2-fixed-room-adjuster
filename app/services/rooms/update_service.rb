module Rooms
  class UpdateService < BaseService
    def initialize(room, params)
      @room = room
      @params = params.dup
    end

    def execute
      @room.update(params)
      @room.save
    end

  end
end
