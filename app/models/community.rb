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
end
