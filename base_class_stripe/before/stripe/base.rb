# frozen_string_literal: true

require 'rest-client'

module Stripe
  class Base
    BASE_URL = 'https://api.stripe.com'

    def post(url, payload)
      RestClient.post(url, payload.to_json, { **api_headers })
    end

    def get(url, params: {})
      RestClient.get(url, { **api_headers, params: params })
    end

    def patch(url, payload)
      RestClient.patch(url, payload.to_json, { **api_headers })
    end

    def delete(url)
      RestClient.delete(url, { **api_headers })
    end

    private

    def api_headers
      {
        accept: 'application/json',
        content_type: 'application/json',
        authorization: "Bearer #{ENV.fetch('STRIPE_API_KEY', nil)}"
      }
    end
  end
end
