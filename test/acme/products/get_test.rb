# frozen_string_literal: true

require 'test_helper'
require 'acme/products/get'

module Acme
  module Products
    class GetTest < Minitest::Test
      def test_call_calls_the_right_endpoint
        stub_request(:get, "https://dummyjson.com/products/1").
          to_return(status: 200,
                    body: {title: "Product title"}.to_json,
                    headers: {"Content-Type" => 'application/json'})
        response_body = Acme::Products::Get.call(1)

        assert_instance_of Hash, response_body
      end
    end
  end
end
