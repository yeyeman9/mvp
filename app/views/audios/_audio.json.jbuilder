json.extract! audio, :id, :interest_id, :audio_url, :name, :description, :air_date, :played_count, :created_at, :updated_at
json.url audio_url(audio, format: :json)