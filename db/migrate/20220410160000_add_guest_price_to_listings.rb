class AddGuestPriceToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :guest_price, :decimal
  end
end
