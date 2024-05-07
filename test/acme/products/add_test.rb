require 'test_helper'
require 'acme/products/add'

module Acme
  module Products
    class AddTest < Minitest::Test
      def test_call_calls_the_right_endpoint
        stub_request(:post, "https://dummyjson.com/products/add").
          to_return(status: 200,
                    body: {"products":{}}.to_json,
                  headers: {"Content-Type" => 'application/json'})
        response_body = Acme::Products::Add.call

        assert_instance_of Hash, response_body
      end
    end
  end
end