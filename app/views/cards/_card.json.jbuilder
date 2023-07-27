json.extract! card, :id, :front, :back, :learned, :user_id, :deck_id, :created_at, :updated_at
json.url card_url(card, format: :json)
