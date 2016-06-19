module Rooms
  class CreateService < BaseService
    def initialize(params)
      @params = params.dup
    end

    def execute
      @room = Room.new(@params)
      @room.save
      @room
    end

  end
end
