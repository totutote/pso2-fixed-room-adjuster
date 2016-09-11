class RoomMember < ApplicationRecord
  before_destroy :before_room_member_destroy

  belongs_to :room
  belongs_to :player_character, optional: true

  def saved?
    id && persisted?
  end

  def before_room_member_destroy
    return unless self.player_character.player
    self.player_character.player.destroy if self.player_character.player.is_guest_user
  end

end
