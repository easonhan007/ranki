# == Schema Information
#
# Table name: questions
#
#  id                 :integer          not null, primary key
#  category_id        :integer          not null
#  user_id            :integer          not null
#  date_of_occurrence :string
#  content            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Question < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :favorites
  has_many :answers

  validates :content, presence: true


  scope :by_created, -> { order('created_at DESC')}
end
