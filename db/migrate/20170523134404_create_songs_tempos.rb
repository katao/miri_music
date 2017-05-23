class CreateSongsTempos < ActiveRecord::Migration[5.0]
  def change
    create_table :songs_tempos, id: false do |t|
      t.references :song, foreign_key: true, unll: false
      t.references :tempo, foreign_key: true, unll: false
    end
  end
end
