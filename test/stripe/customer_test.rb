require "test_helper"
require "stripe/customer"

module Stripe
  class CustomerTest < Minitest::Test
    def test_create_customer
      attributes = { email: "example@example.com", name: "Example User" }
      stub_request(:post, "https://api.stripe.com/v1/customers")
        .with(body: attributes.to_json)
        .to_return(status: 200,
                   body: {
                     id: "cust_123",
                     email: "example@example.com",
                     name: "Example User"
                   }.to_json,
                   headers: {})

      customer_api = Stripe::Customer.new
      response = customer_api.create(attributes)

      assert_equal "cust_123", response["id"]
      assert_equal "example@example.com", response["email"]
      assert_equal "Example User", response["name"]
    end

    def test_list_customers
      stub_request(:get, "https://api.stripe.com/v1/customers")
        .to_return(status: 200, body: [{ id: "cust_001" },
                                       { id: "cust_002" }].to_json, headers: {})

      customer_api = Stripe::Customer.new
      response = customer_api.list

      assert_instance_of Array, response
      assert_equal 2, response.size
      assert_equal "cust_001", response.first["id"]
      assert_equal "cust_002", response.last["id"]
    end

    def test_fetch_one_customer
      customer_id = "cust_123"
      stub_request(:get, URI.join("https://api.stripe.com/v1/customers/", customer_id))
        .to_return(status: 200, body: { id: customer_id,
                                        email: "test@example.com" }.to_json, headers: {})

      customer_api = Stripe::Customer.new
      response = customer_api.fetch_one(customer_id)

      assert_equal customer_id, response["id"]
      assert_equal "test@example.com", response["email"]
    end

    def test_patch_customer
      customer_id = "cust_123"
      attributes = { email: "updated@example.com" }
      stub_request(:patch, URI.join("https://api.stripe.com/v1/customers/", customer_id))
        .with(body: attributes.to_json)
        .to_return(status: 200, body: { id: customer_id,
                                        email: "updated@example.com" }.to_json, headers: {})

      customer_api = Stripe::Customer.new
      response = customer_api.patch(customer_id, attributes)

      assert_equal customer_id, response["id"]
      assert_equal "updated@example.com", response["email"]
    end

    def test_delete_customer
      customer_id = "cust_123"
      stub_request(:delete, URI.join("https://api.stripe.com/v1/customers/", customer_id))
        .to_return(status: 200, body: { id: customer_id,
                                        deleted: true }.to_json, headers: {})

      customer_api = Stripe::Customer.new
      response = customer_api.delete(customer_id)

      assert_equal customer_id, response["id"]
      assert_equal true, response["deleted"]
    end
  end
end
