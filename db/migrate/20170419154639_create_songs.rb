class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :gn_id
      t.integer :album_id
      t.string :artist
      t.string :title
      t.integer :track_num

      t.timestamps
    end
  end
end
