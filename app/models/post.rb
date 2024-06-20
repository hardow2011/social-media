# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  unique_id  :string(11)       not null
#
# Indexes
#
#  index_posts_on_unique_id  (unique_id) UNIQUE
#
class Post < ApplicationRecord
  require 'securerandom'

  # belongs_to :user

  before_validation :assign_unique_id, on: :create

  validates :unique_id, format: { with: /[a-zA-Z0-9]*/ }, length: { is: 11 },
            presence: true, uniqueness: true, allow_blank: false,
            allow_nil: false, on: :create

  attr_readonly :unique_id

  private

  def assign_unique_id
    self.unique_id = SecureRandom.alphanumeric(11)
    assign_unique_id if Post.exists?(unique_id: self.unique_id)
  end
end
