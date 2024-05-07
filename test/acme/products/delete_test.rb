# frozen_string_literal: true

require 'test_helper'
require 'acme/products/delete'

module Acme
  module Products
    class DeleteTest < Minitest::Test
      def test_call_calls_the_right_endpoint
        stub_request(:delete, "https://dummyjson.com/products/1").
          to_return(status: 200,
                    body: "{}",
                    headers: { "Content-Type" => "appliation/json"})
        response_body = Acme::Products::Delete.call(1)
        assert_empty response_body
      end
    end
  end
end
