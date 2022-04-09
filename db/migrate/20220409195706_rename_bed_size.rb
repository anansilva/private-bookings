class RenameBedSize < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :beds, :size, :bed_size
  end

  def self.down
    rename_column :beds, :bed_size, :size
  end
end
