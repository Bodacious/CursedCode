require "stripe/base"

module Stripe
  class Customer < Base
    CUSTOMER_BASE_URL = "#{BASE_URL}/v1/customers".freeze

    def list
      response = get(CUSTOMER_BASE_URL)

      JSON.parse(response)
    end

    def create(attributes)
      response = post(CUSTOMER_BASE_URL, attributes)

      JSON.parse(response)
    end

    def fetch_one(id)
      endpoint = [CUSTOMER_BASE_URL, id].join("/")

      response = get(endpoint)

      JSON.parse(response)
    end

    def patch(id, attributes)
      endpoint = [CUSTOMER_BASE_URL, id].join("/")

      response = super(endpoint, attributes)

      JSON.parse(response)
    end

    def delete(id)
      endpoint = [CUSTOMER_BASE_URL, id].join("/")

      response = super(endpoint)

      JSON.parse(response)
    end

    def search(query)
      endpoint = "#{CUSTOMER_BASE_URL}?query:#{query}"

      response = get(endpoint)

      JSON.parse(response)
    end
  end
end
