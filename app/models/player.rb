class Player < ApplicationRecord
  validates :player_id_name, presence: true, uniqueness: true

  has_many :room_members
  has_many :rooms, through: :room_members
  has_many :player_characters, dependent: :destroy

  belongs_to :user

  def saved?
    id && persisted?
  end
end
