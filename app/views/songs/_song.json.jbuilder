json.extract! song, :id, :song_url, :platform, :created_at, :updated_at
json.url song_url(song, format: :json)
