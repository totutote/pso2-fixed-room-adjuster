class RoomMember < ApplicationRecord
  belongs_to :room
  belongs_to :player

  def saved?
    id && persisted?
  end
end
