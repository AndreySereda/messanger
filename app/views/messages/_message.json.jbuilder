json.extract! message, :id, :text, :created_at, :updated_at
json.url messages_url(message, format: :json)