# == Schema Information
#
# Table name: import_records
#
#  id         :integer          not null, primary key
#  csv        :text
#  user_id    :integer          not null
#  success    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ImportRecord < ApplicationRecord
  belongs_to :user

  validates :csv, presence: true

  def do(user)
    count = 0
    deck = user.decks.first
    data = CSV.parse(csv, headers: true)
    # puts(data)
    data.each do |row|
      c = Card.new(front: row['front'], back: row['back'], deck_id: deck.id, user_id: user.id)
      if c.save!
        count = count + 1
      end
    end #each
    return count
  end

end
