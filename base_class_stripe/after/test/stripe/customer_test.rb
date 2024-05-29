# frozen_string_literal: true

require 'test_helper'
require 'stripe/customer'
require 'mocha/minitest'

module Stripe
  class CustomerTest < Minitest::Test
    def test_create_customer
      attributes = { email: 'example@example.com', name: 'Example User' }
      api_client = stub('APIClient')
      customer_api = Stripe::Customer.new(api_client)

      api_client.expects(:post).with("/v1/customers", attributes).returns("{}")

      response = customer_api.create(attributes)

      assert_instance_of(Hash, response)
    end

    def test_list_customers
      api_client = stub('APIClient')
      customer_api = Stripe::Customer.new(api_client)

      api_client.expects(:get).with("/v1/customers").returns("[{}]")
      response = customer_api.list

      assert_instance_of Array, response
    end

    def test_fetch_one_customer
      customer_id = 'cust_123'
      api_client = stub('APIClient')
      customer_api = Stripe::Customer.new(api_client)

      api_client.expects(:get).with("/v1/customers/#{customer_id}").returns("{}")
      response = customer_api.fetch_one(customer_id)

      assert_instance_of(Hash, response)
    end

    def test_patch_customer
      customer_id = 'cust_123'
      attributes = { email: 'updated@example.com' }
      api_client = stub('APIClient')
      customer_api = Stripe::Customer.new(api_client)

      api_client.expects(:patch).with("/v1/customers/#{customer_id}", attributes).returns("{}")
      response = customer_api.patch(customer_id, attributes)

      assert_instance_of(Hash, response)
    end

    def test_delete_customer
      customer_id = 'cust_123'
      api_client = stub('APIClient')

      customer_api = Stripe::Customer.new(api_client)
      api_client.expects(:delete).with("/v1/customers/#{customer_id}").returns("{}")

      response = customer_api.delete(customer_id)

      assert_instance_of(Hash, response)
    end
  end
end
