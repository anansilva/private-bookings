class Listing < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :title, presence: true
  validates :nightly_price, numericality: { greater_than: 0 }
  validates :max_guests, numericality: { greater_than: 0 }

  enum status: [:draft, :published, :archived]

  scope :published, -> { where(status: :published) }

  after_commit :create_stripe_product, only: [:create, :update]

  # TODO: Move to a service/job
  def create_stripe_product
    return if self.stripe_product_id.present?

    product = Stripe::Product.create(
      name: self.title,
      description: "Preço total da estadia (diária + preço por pessoa)",
      url: Rails.application.routes.url_helpers.listing_url(self),
      images: self.stripe_product_images,
      metadata: {
        private_bookings_id: self.id
      }
    )

    self.update(stripe_product_id: product.id)
  end

  private

  def stripe_product_images
    return [] if self.photos.empty?

    self.photos.map(&:image_url)
  end
end
