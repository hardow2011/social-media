# == Schema Information
#
# Table name: communities
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  handle      :string           not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_communities_on_handle  (handle)
#
class Community < ApplicationRecord
  has_many :posts

  before_create :strip_fields, :set_handle

  # The id will be the handle
  def to_param
    handle
  end

  def self.get_by_handle(handle)
    Community.find_sole_by(handle: handle)
  end

  private

  def strip_fields
    self.name = self.name.strip
    self.description = self.description.strip
  end

  def set_handle
    self.handle = self.name.parameterize
  end
end
