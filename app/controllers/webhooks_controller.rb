class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  AUTHORIZED_SOURCES = %w[
    stripe
  ].freeze

  def create
    if AUTHORIZED_SOURCES.include?(params[:source])
      event = Event.create!(
        request_body: request.body.read,
        source: params[:source],
      )

      EventJob.perform_later(event)

      render json: { message: 'success' }
    else
      render json: { message: 'unauthorized event' }
    end
  end
end
