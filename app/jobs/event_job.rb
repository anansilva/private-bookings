class EventJob < ApplicationJob
  queue_as :default

  #TODO send stripe to a specific service.
  #This job should handle different event sources.
  #
  def perform(event)
    # Stripe construct_from
    # https://stripe.com/docs/api/events/object#event_object-object
    stripe_event = Stripe::Event.construct_from(
      JSON.parse(event.request_body, symbolize_names: true)
    )

    begin
      handle_stripe(stripe_event)

      event.update(
        status: :processing,
        error_message: nil
      )
    rescue => e
      event.update(
        event_type: stripe_event.type,
        status: :failed,
        error_message: e.message
      )
    end
  end

  private

  def handle_stripe(stripe_event)
    case stripe_event.type
    when "stripe"
      checkout_session = stripe_event.data.object
      puts "Checkout session: #{checkout_session.id}"
      puts "Checkout session: #{checkout_session.client_reference_id}"
      puts "Checkout session: #{checkout_session.payment_intent}"
    end
  end

end
