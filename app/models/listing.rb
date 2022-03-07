class Listing < ApplicationRecord
  validates :title, presence: true
  enum status: [:draft, :published, :archived]
end
