# == Schema Information
#
# Table name: settings
#
#  id           :integer          not null, primary key
#  openai_key   :string
#  openai_proxy :string
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  llm_model    :string           default("gpt-3.5-turbo")
#
require "test_helper"

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
