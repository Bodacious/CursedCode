# frozen_string_literal: true

require 'rest-client'

module Stripe
  class APIClient
    BASE_URL = 'https://api.stripe.com'

    def post(path, payload)
      url = url_for_path(path)
      RestClient.post(url, payload.to_json, { **api_headers })
    end

    def get(path, params: {})
      url = url_for_path(path)
      RestClient.get(url, { **api_headers, params: params })
    end

    def patch(path, payload)
      url = url_for_path(path)
      RestClient.patch(url, payload.to_json, { **api_headers })
    end

    def delete(path)
      url = url_for_path(path)
      RestClient.delete(url, { **api_headers })
    end

    private

    def url_for_path(path)
      URI.join(BASE_URL, path).to_s
    end

    def api_headers
      {
        accept: 'application/json',
        content_type: 'application/json',
        authorization: "Bearer #{ENV.fetch('STRIPE_API_KEY', nil)}"
      }
    end
  end
end
