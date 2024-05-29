# frozen_string_literal: true

class Webhooks::AnkaPayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    # Handle webhook data here
    puts "Webhook received!"
    puts "Webhook data: #{params.inspect}"
    render json: { message: 'Webhook received' }, status: :ok
  end
end
