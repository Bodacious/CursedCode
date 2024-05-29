# frozen_string_literal: true

require 'test_helper'
require 'stripe/subscription'
require 'mocha/minitest'

module Stripe
  class SubscriptionTest < Minitest::Test
    def test_create_subscription
      attributes = { customer: 'cust_123', items: [{ price: 'price_001' }] }
      api_client = stub('APIClient')

      subscription_api = Stripe::Subscription.new(api_client)
      api_client.expects(:post).with('/v1/subscriptions', attributes).returns({})
      response = subscription_api.create('cust_123', 'price_001')

      assert_instance_of(Hash, response)
    end

    def test_fetch_one_subscription
      subscription_id = 'sub_123'
      api_client = stub('APIClient')
      subscription_api = Stripe::Subscription.new(api_client)

      api_client.expects(:get).with("/v1/subscriptions/#{subscription_id}").returns({})
      response = subscription_api.fetch_one(subscription_id)

      assert_instance_of(Hash, response)
    end

    def test_resume_subscription
      subscription_id = 'sub_123'
      attributes = { billing_cycle_anchor: 'now' }
      api_client = stub('APIClient')
      subscription_api = Stripe::Subscription.new(api_client)

      api_client.expects(:post)
                .with("/v1/subscriptions/#{subscription_id}", {billing_cycle_anchor: 'now' })
                .returns({})
      response = subscription_api.resume(subscription_id, attributes)

      assert_instance_of(Hash, response)
    end

    def test_cancel_subscription
      subscription_id = 'sub_123'
      api_client = stub('APIClient')
      subscription_api = Stripe::Subscription.new(api_client)

      api_client.expects(:delete).with("/v1/subscriptions/#{subscription_id}").returns({})
      response = subscription_api.cancel(subscription_id)

      assert_instance_of(Hash, response)
    end
  end
end
