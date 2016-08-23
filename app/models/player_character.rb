class PlayerCharacter < ApplicationRecord
  CLASS_LIST = ["Hu", "Fi", "Ra", "Gu", "Fo", "Te", "Br", "Bo", "Su"]

  belongs_to :player

  def saved?
    id && persisted?
  end
end
