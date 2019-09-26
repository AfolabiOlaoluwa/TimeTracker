json.extract! clock_entry, :id, :user_id, :purpose, :time_in, :time_out, :created_at, :updated_at
json.url clock_entry_url(clock_entry, format: :json)
