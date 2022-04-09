class Listing < ApplicationRecord
  validates :title, presence: true
  enum status: [:draft, :published, :archived]

  scope :published, -> { where(status: :published) }
end
