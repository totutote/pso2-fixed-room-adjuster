class Room < ApplicationRecord
  validates :name, presence: true
  validates :quest_start_time, presence: true
  validates :quest_end_time, presence: true

  has_many :room_members
  has_many :players, through: :room_members, dependent: :destroy

  def saved?
    id && persisted?
  end
end
