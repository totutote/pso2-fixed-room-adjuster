class Room < ApplicationRecord
  validates :name, presence: true
  validates :quest_start_time, presence: true
  validates :quest_end_time, presence: true

  def saved?
    id && persisted?
  end
end
