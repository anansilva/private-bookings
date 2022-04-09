class AddNightlyPriceToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :nightly_price, :decimal
  end
end
