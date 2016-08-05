class RoomComment < ApplicationRecord
  def saved?
    id && persisted?
  end
end
