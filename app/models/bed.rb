class Bed < ApplicationRecord
  belongs_to :room

  enum bed_size: { single: 0, double: 1, queen: 2, king: 3 }
end
