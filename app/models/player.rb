class Player < ApplicationRecord
  validates :player_id_name, presence: true

  has_many :player_characters, dependent: :destroy

  belongs_to :user, optional: true

  def saved?
    id && persisted?
  end
end
