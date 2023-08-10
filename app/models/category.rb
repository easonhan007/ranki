# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  belongs_to :user

  has_many :questions

  validates :name, presence: true, uniqueness: true
end
