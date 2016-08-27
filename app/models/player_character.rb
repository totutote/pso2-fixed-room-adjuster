class PlayerCharacter < ApplicationRecord
  CLASS_LIST = ["Hu", "Fi", "Ra", "Gu", "Fo", "Te", "Br", "Bo", "Su"]

  belongs_to :player
  has_many :player_character_class_sets

  def saved?
    id && persisted?
  end
end
