# frozen_string_literal: true

class Webhooks::AnkaPayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    # Handle webhook data here
    puts 'Webhook received!'
    puts "Data: #{params[:data]}"
    order = Order.find_by(id: params[:data][:attributes][:internal_reference])
    order.update(status: params[:data][:attributes][:status])

    render json: { message: 'Webhook received' }, status: :ok
  end
end
