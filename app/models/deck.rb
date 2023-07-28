# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards

  scope :recent, -> { order('updated_at DESC').limit(4) }
end
