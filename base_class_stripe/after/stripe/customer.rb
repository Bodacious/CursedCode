# frozen_string_literal: true

require_relative 'api_client'

module Stripe
  class Customer
    CUSTOMER_BASE_URL = '/v1/customers'

    attr_reader :api_client

    def initialize(api_client = APIClient.new)
      @api_client = api_client
    end

    def list
      api_client.get(CUSTOMER_BASE_URL)
    end

    def create(attributes)
      api_client.post(CUSTOMER_BASE_URL, attributes)
    end

    def fetch_one(id)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      api_client.get(endpoint)
    end

    def patch(id, attributes)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      api_client.patch(endpoint, attributes)
    end

    def delete(id)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      api_client.delete(endpoint)
    end

    def search(query)
      endpoint = "#{CUSTOMER_BASE_URL}?query:#{query}"

      get(endpoint)
    end
  end
end
