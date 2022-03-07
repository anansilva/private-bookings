class AddStatusToListings < ActiveRecord::Migration[7.0]
  def change
    change_table :listings do |t|
      t.integer :status, null: false, default: 0
    end
  end
end
