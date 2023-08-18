# == Schema Information
#
# Table name: ai_prompts
#
#  id         :integer          not null, primary key
#  name       :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class AiPromptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
