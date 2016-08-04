class Room < ApplicationRecord
  before_create :generate_random_id

  validates :name, presence: true
  validates :quest_start_time, presence: true
  validates :quest_end_time, presence: true

  has_many :room_members, dependent: :destroy
  has_many :players, through: :room_members

  belongs_to :group, optional: true

  has_many :room_comments, dependent: :destroy

  def saved?
    id && persisted?
  end

  def group_uuid
    @group_uuid
  end

  def group_uuid=(uuid)
    @group_uuid = uuid
    return if uuid == ''
    group = Group.where(uuid: uuid).first
    self.group_id = group ? group.id : nil
  end

  private 

  def generate_random_id
    self.uuid = SecureRandom.uuid
  end 

end
