# frozen_string_literal: true
require 'test_helper'
require 'stripe/subscription'

module Stripe
  class SubscriptionTest < Minitest::Test
    def test_create_subscription
      attributes = { customer: 'cust_123', items: [{ price: 'price_001' }] }
      stub_request(:post, "https://api.stripe.com/v1/subscriptions")
        .with(body: attributes.to_json)
        .to_return(status: 200,
                   body: {
                     id: 'sub_123',
                     customer: 'cust_123',
                     items: [{ price: 'price_001' }]
                   }.to_json,
                   headers: {})

      subscription_api = Stripe::Subscription.new
      response = subscription_api.create('cust_123', 'price_001')

      assert_equal 'sub_123', response['id']
      assert_equal 'cust_123', response['customer']
      assert_equal 'price_001', response['items'].first['price']
    end

    def test_fetch_one_subscription
      subscription_id = 'sub_123'
      stub_request(:get, "https://api.stripe.com/v1/subscriptions/#{subscription_id}")
        .to_return(status: 200,
                   body: {
                     id: subscription_id,
                     customer: 'cust_123',
                     status: 'active'
                   }.to_json,
                   headers: {})

      subscription_api = Stripe::Subscription.new
      response = subscription_api.fetch_one(subscription_id)

      assert_equal subscription_id, response['id']
      assert_equal 'cust_123', response['customer']
      assert_equal 'active', response['status']
    end

    def test_resume_subscription
      subscription_id = 'sub_123'
      attributes = { billing_cycle_anchor: 'now' }
      stub_request(:post, "https://api.stripe.com/v1/subscriptions/#{subscription_id}")
        .with(body: attributes.to_json)
        .to_return(status: 200,
                   body: {
                     id: subscription_id,
                     status: 'active'
                   }.to_json,
                   headers: {})

      subscription_api = Stripe::Subscription.new
      response = subscription_api.resume(subscription_id, attributes)

      assert_equal subscription_id, response['id']
      assert_equal 'active', response['status']
    end

    def test_cancel_subscription
      subscription_id = 'sub_123'
      stub_request(:delete, "https://api.stripe.com/v1/subscriptions/#{subscription_id}")
        .to_return(status: 200,
                   body: {
                     id: subscription_id,
                     status: 'cancelled'
                   }.to_json,
                   headers: {})

      subscription_api = Stripe::Subscription.new
      response = subscription_api.cancel(subscription_id)

      assert_equal subscription_id, response['id']
      assert_equal 'cancelled', response['status']
    end
  end
end
