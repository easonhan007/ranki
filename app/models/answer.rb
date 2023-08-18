# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  keywords    :text
#
class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :content, presence: true
end
