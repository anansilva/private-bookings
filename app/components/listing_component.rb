# frozen_string_literal: true

class ListingComponent < ViewComponent::Base
  with_collection_parameter :listing

  def initialize(listing:)
    @listing = listing
  end
end
