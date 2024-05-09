require "stripe/base"

module Stripe
  class Customer < Base
    CUSTOMER_BASE_URL = "#{BASE_URL}/v1/customers"

    # Can be made better to limit the number of results
    def list
      response = get(CUSTOMER_BASE_URL)

      # This is normally parsed as JSON but if required it can be converted to whatever other data type as required from here
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

      response = patch(endpoint, attributes)

      JSON.parse(response)
    end

    def delete(id)
      endpoint = [CUSTOMER_BASE_URL, id].join("/")

      delete(endpoint)
    end

    def search(query)
      endpoint = "#{CUSTOMER_BASE_URL}?query:#{query}"

      response = get(endpoint)

      JSON.parse(response)
    end
  end
end
