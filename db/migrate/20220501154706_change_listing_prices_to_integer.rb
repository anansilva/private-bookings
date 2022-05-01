class ChangeListingPricesToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :listings, :nightly_price, :integer
    change_column :listings, :cleaning_fee, :integer
    change_column :listings, :guest_price, :integer
  end
end
