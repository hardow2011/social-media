# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  handle      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_communities_on_handle  (handle)
#
class Community < ApplicationRecord
  include DataFormatting
  has_many :posts
  has_and_belongs_to_many :users

  before_validation do
    unless self.handle.present?
      self.errors.add(:handle, :present, message: "can't be blank.")
    end
    strip_whitespace(:handle)
    if Community.where(handle: self.handle).exists?
      self.errors.add(:handle, :uniqueness, message: "must be unique.")
    end
  end

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

  private

  def validate_handle
    # Only accept alphanumeric chars and hypens
    unless self.handle.match?(/^[a-zA-Z0-9-]+$/)
      self.errors.add(:handle, 'Handle not valid')
    end
  end
end
