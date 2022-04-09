class Listing < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :title, presence: true

  enum status: [:draft, :published, :archived]

  scope :published, -> { where(status: :published) }
end
