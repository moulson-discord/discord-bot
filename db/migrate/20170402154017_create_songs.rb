class CreateSongs < ActiveRecord::Migration[5.0]
  def up
    create_table :songs do |t|
      t.string :song_url
      t.string :platform

      t.timestamps
    end
  end
end
