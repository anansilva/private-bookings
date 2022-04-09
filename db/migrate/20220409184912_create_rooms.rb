class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :listing, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
