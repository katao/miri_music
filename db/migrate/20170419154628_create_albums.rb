class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :gn_id
      t.string :artist
      t.string :title
      t.date :release_date
      t.integer :track_count
      t.string :genre
      t.string :url

      t.timestamps
    end
  end
end
