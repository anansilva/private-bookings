# frozen_string_literal: true

class BedComponent < ViewComponent::Base
  with_collection_parameter :bed

  def initialize(bed:)
    @bed = bed
  end
end
