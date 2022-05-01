class ReservationsController < ApplicationController
  def index
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      listing = @reservation.listing

      checkout_session = Stripe::Checkout::Session.create(
        # payment_method_types: ['card'],
        success_url: reservation_url(@reservation),
        cancel_url: listing_url(listing),
        customer: current_user.stripe_customer_id,
        mode: 'payment',
        line_items: [{
          price_data: {
            unit_amount: listing.nightly_price,
            currency: 'eur',
            product: listing.stripe_product_id,
          },
          quantity: 1 #number of nights,
        }, {
          price_data: {
            unit_amount: listing.cleaning_fee,
            currency: 'eur',
            product: 'prod_Lb7gLcRlEoiNzM',
          },
          quantity: 1
        }],
        metadata: {
          reservation_id: @reservation.id
        },
        payment_intent_data: {
          metadata: {
            reservation_id: @reservation.id
          }
        }
      )

      @reservation.update(session_id: checkout_session.id)
      redirect_to checkout_session.url, allow_other_host: true
    else
      redirect_to @reservation.listing, notice: "Sorry, your reservation could not be created."
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:listing_id)
  end
end
