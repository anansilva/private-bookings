class Room < ApplicationRecord
  belongs_to :listing
  has_many :beds, dependent: :destroy
  accepts_nested_attributes_for :beds, allow_destroy: true

  enum room_type: { single: 0, double: 1, triple: 2, quad: 3 }
end
