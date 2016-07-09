class Player < ApplicationRecord
  validates :player_id_name, presence: true

  has_many :room_members
  has_many :rooms, through: :room_members, dependent: :destroy
end
