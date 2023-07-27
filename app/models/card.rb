# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  front      :string
#  back       :text
#  learned    :boolean          default(FALSE)
#  user_id    :integer          not null
#  deck_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck
end
