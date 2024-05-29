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
      response = api_client.get(CUSTOMER_BASE_URL)

      JSON.parse(response)
    end

    def create(attributes)
      response = api_client.post(CUSTOMER_BASE_URL, attributes)

      JSON.parse(response)
    end

    def fetch_one(id)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      response = api_client.get(endpoint)

      JSON.parse(response)
    end

    def patch(id, attributes)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      response = api_client.patch(endpoint, attributes)

      JSON.parse(response)
    end

    def delete(id)
      endpoint = [CUSTOMER_BASE_URL, id].join('/')

      response = api_client.delete(endpoint)

      JSON.parse(response)
    end

    def search(query)
      endpoint = "#{CUSTOMER_BASE_URL}?query:#{query}"

      response = get(endpoint)

      JSON.parse(response)
    end
  end
end
