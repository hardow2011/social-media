# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  handle      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :bigint           not null
#
# Indexes
#
#  index_communities_on_creator_id  (creator_id)
#  index_communities_on_handle      (handle)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
class Community < ApplicationRecord
  include DataFormatting
  has_many :posts
  has_and_belongs_to_many :users
  belongs_to :creator, class_name: 'User'

  validate :handle_format

  before_save do
    strip_whitespace(:description)
  end

  # The id will be the handle
  def to_param
    handle
  end

  def self.get_by_handle(handle)
    Community.find_sole_by(handle: handle)
  end

  def created_by
    self.creator
  end

  private

  def handle_format
    unless self.handle.present?
      self.errors.add(:handle, :present, message: "can't be blank.")
      return
    end
    strip_whitespace(:handle)
    if Community.where(handle: self.handle).exists?
      self.errors.add(:handle, :uniqueness, message: "must be unique.")
    end
    # Only accept alphanumeric chars and hypens
    unless self.handle.match?(/^[a-zA-Z0-9-]+$/)
      self.errors.add(:handle, 'must only contain letter, numbers and hyphens.')
    end
  end
end
