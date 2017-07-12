class AddAttachmentsToSong < ActiveRecord::Migration[5.0]
  def up
  	add_attachment :songs, :song_file
  	add_attachment :songs, :thumb
  end
end
