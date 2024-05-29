# frozen_string_literal: true

require "rest-client"
require "forwardable"
require "json"
module Stripe
  class APIClient
    extend Forwardable

    BASE_URL = "https://api.stripe.com"

    def_delegator :JSON, :parse, :parse_json

    def post(path, payload)
      url = url_for_path(path)
      response = RestClient.post(url, payload.to_json, { **api_headers })
      parse_json(response)
    end

    def get(path, params: {})
      url = url_for_path(path)
      response = RestClient.get(url, { **api_headers, params: params })
      parse_json(response)
    end

    def patch(path, payload)
      url = url_for_path(path)
      response = RestClient.patch(url, payload.to_json, { **api_headers })
      parse_json(response)
    end

    def delete(path)
      url = url_for_path(path)
      response = RestClient.delete(url, { **api_headers })
      parse_json(response)
    end

    private

    def parse_json(json_string)
      JSON.parse(json_string)
    end

    def url_for_path(path)
      URI.join(BASE_URL, path).to_s
    end

    def api_headers
      {
        accept: "application/json",
        content_type: "application/json",
        authorization: "Bearer #{ENV.fetch('STRIPE_API_KEY', nil)}"
      }
    end
  end
end
