class Post < ApplicationRecord
  require 'securerandom'

  belongs_to :user

  before_validation :unique_identifier

  validates :unique_identifier, format: { with: /^[a-zA-Z0-9]*$/ }, length: { is: 11 },
            presence: true, uniqueness: true, allow_blank: false,
            allow_nil: false, on: :create

  attr_readonly :unique_identifier

  private

  def assign_unique_identifier
    self.unique_identifier = SecureRandom.alphanumeric(11)
    assign_unique_identifier if Post.exists?(unique_identifier: self.unique_identifier)
  end
end
