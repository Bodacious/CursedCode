# frozen_string_literal: true

require "test_helper"
require "acme/products/list"

module Acme
  module Products
    class ListTest < Minitest::Test
      def test_call_calls_the_right_endpoint
        stub_request(:get, "https://dummyjson.com/products")
          .to_return(status: 200,
                     body: { products: [{ id: 1, title: "product-title" }] }.to_json,
                     headers: { "Content-Type" => "application/json" })

        response_body = Acme::Products::List.call

        assert_instance_of Hash, response_body
      end
    end
  end
end
