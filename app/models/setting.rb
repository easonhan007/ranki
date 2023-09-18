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
#
class Setting < ApplicationRecord
  belongs_to :user

  def self.llm_models
    %w[gpt-4 gpt-4-0314 gpt-4-32k gpt-3.5-turbo gpt-3.5-turbo-0301 text-davinci-003]
  end
end
