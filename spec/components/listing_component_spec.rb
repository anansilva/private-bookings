# frozen_string_literal: true

require "rails_helper"

RSpec.describe ListingComponent, type: :component do
  listing_1 = Listing.create(title: 'Listing 1', nightly_price: 10, max_guests: 2)
  listing_2 = Listing.create(title: 'Listing 2', nightly_price: 20, max_guests: 2)

  it "renders a listing" do
    render_inline(described_class.new(listing: listing_1))

    expect(page).to have_text('Listing 1')
  end

  it "renders a listing collection" do
    render_inline(described_class.with_collection(Listing.all))

    expect(page).to have_text('Listing 2')
    expect(page).to have_text('Listing 1')
  end
end
