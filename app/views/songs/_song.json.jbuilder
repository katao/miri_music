json.extract! song, :id, :gn_id, :album_id, :artist, :title, :track_num, :genre, :modo, :tempo, :created_at, :updated_at
json.url song_url(song, format: :json)
