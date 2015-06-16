json.array!(@entries) do |entry|
  json.extract! entry, :id, :name, :content_entry, :user_id, :integer
  json.url entry_url(entry, format: :json)
end
