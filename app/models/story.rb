# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  words      :text
#  word_count :integer          default(5)
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Story < ApplicationRecord
  belongs_to :user

  validates :word_count, presence: true
  validates :word_count, numericality: { only_integer: true, greater_than: 0 }
end
