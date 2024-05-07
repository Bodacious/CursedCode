# frozen_string_literal: true

require "test_helper"
require "acme/products/update"

module Acme
  module Products
    class ListTest < Minitest::Test
      def test_call_calls_the_right_endpoint
        stub_request(:patch, "https://dummyjson.com/products/1")
          .with(body: { title: "new-title" })
          .to_return(status: 200,
                     body: { id: 1, title: "new-title" }.to_json,
                     headers: { "Content-Type" => "application/json" })
        response_body = Acme::Products::Update.call(1, title: "new-title")

        assert_instance_of Hash, response_body
      end
    end
  end
end
