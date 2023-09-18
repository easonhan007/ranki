json.extract! story, :id, :words, :word_count, :content, :user_id, :created_at, :updated_at
json.url story_url(story, format: :json)
