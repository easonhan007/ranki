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
require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
