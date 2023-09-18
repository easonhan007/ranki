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
require "test_helper"

class StoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
