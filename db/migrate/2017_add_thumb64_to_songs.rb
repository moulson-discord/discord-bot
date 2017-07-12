class AddThumb64ToSongs < ActiveRecord::Migration[5.0]
  def up
    add_column :songs, :thumb64, :text
  end
end
