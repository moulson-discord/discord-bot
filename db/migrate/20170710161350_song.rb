class Song < ActiveRecord::Migration[5.0]
  def up
    add_column :songs, :title, :string
  end
end
