class CreateMoodsSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :moods_songs, id: false do |t|
      t.references :song, foreign_key: true, unll: false
      t.references :mood, foreign_key: true, unll: false
    end
  end
end
