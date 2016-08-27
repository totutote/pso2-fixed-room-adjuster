class PlayerCharacterClassSet < ApplicationRecord
  validates :name, presence: true

  belongs_to :player_character

  def saved?
    id && persisted?
  end
end
