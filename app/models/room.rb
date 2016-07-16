class Room < ApplicationRecord
  before_create :generate_random_id

  validates :name, presence: true
  validates :quest_start_time, presence: true
  validates :quest_end_time, presence: true

  has_many :room_members
  has_many :players, through: :room_members, dependent: :destroy

  def saved?
    id && persisted?
  end

  private 

  def generate_random_id
    self.uuid = SecureRandom.uuid
  end 

end
