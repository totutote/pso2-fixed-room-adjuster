class Group < ApplicationRecord
  before_create :generate_random_id

  has_many :rooms

  validates :name, presence: true

  def saved?
    id && persisted?
  end

  private 

  def generate_random_id
    self.uuid = SecureRandom.uuid
  end 

end
