class AddCleaningFeeToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :cleaning_fee, :decimal
  end
end
