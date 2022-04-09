class RenameRoomType < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :rooms, :type, :room_type
  end

  def self.down
    rename_column :rooms, :room_type, :type
  end
end
