json.extract! album, :id, :gn_id, :artist, :title, :release_date, :track_count, :genre, :url, :created_at, :updated_at
json.url album_url(album, format: :json)
