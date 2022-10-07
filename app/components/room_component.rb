# frozen_string_literal: true

class RoomComponent < ViewComponent::Base
  with_collection_parameter :room

  def initialize(room:)
    @room = room
  end
end
