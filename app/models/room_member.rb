class RoomMember < ApplicationRecord
  before_destroy :before_room_member_destroy

  belongs_to :room
  belongs_to :player

  def saved?
    id && persisted?
  end

  def before_room_member_destroy
    self.player.destroy if self.player.is_guest_user
  end

end
