# frozen_string_literal: true

require 'json'

class OrdersController < ApplicationController
  def create
    @product = Product.find(params[:order][:product_id])
    @order = Order.new(order_params)

    return unless @order.save

    # Call Anka Pay API to generate payment link
    payment_link = generate_payment_link(@order)
    return unless payment_link

    @order.update(
      payment_token: payment_link['payment_token'],
      redirect_url: payment_link['redirect_url']
    )

    redirect_to @order.redirect_url, allow_other_host: true
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :amount)
  end

  def generate_payment_link(order)
    # Use Faraday Typhoeus adapter to create a payment link with Anka Pay API
    data = {
      data: {
        type: 'payment_links',
        attributes: {
          title: order.product.name,
          amount_cents: (order.amount * 100).to_i,
          amount_currency: 'USD',
          shippable: true,
          reusable: false,
          callback_url: order_url(order),
          order_reference: order.id.to_s
        }
      }
    }

    url = "#{ENV['ANKA_API_HOST']}/payment/links"
    token = ENV['ANKA_API_TOKEN']

    request = Typhoeus::Request.post(
      url,
      body: data.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{token}"
      },
      ssl_verifypeer: false,
      ssl_verifyhost: 0
    )

    JSON.parse(request.body)
  end
end
