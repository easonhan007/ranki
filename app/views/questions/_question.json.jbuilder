json.extract! question, :id, :category_id, :user_id, :date_of_occurrence, :content, :created_at, :updated_at
json.url question_url(question, format: :json)
