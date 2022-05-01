class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :reservations, foreign_key: :guest_id

  after_commit :create_stripe_customer, on: [:create, :update]

  # TODO: move this to a job
  def create_stripe_customer
    return if self.stripe_customer_id.present?

    customer = Stripe::Customer.create(
      email: self.email,
      name: self.full_name,
      metadata: {
        private_bookings_id: self.id,
      }
    )

    self.update(stripe_customer_id: customer.id)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    unless user
     user = create_from_omniauth!(data)
    end

    user.skip_confirmation!
    user
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def self.create_from_omniauth!(data)
    User.create!(
      first_name: data['first_name'],
      last_name: data['last_name'],
      provider: data['provider'],
      uid: data['uid'],
      email: data['email'],
      password: Devise.friendly_token[0,20],
      avatar: data['image']
    )
  end
end
