class RoomMember < ApplicationRecord
  before_destroy :before_room_member_destroy

  belongs_to :room
  belongs_to :player
  belongs_to :player_character, optional: true

  def saved?
    id && persisted?
  end

  def before_room_member_destroy
    return unless self.player
    self.player.destroy if self.player.is_guest_user
  end

end
