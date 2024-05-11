# frozen_string_literal: true

require "rest-client"

module Stripe
  class Base
    BASE_URL = "https://api.stripe.com"

    def post(url, payload)
      response = RestClient.post(url, payload.to_json, { **api_headers })
      response
    rescue RestClient::ExceptionWithResponse => e
      raise e
    end

    def get(url, params: {}, string_params: false)
      response = RestClient.get(url, { **api_headers, params: })
      response
    rescue RestClient::ExceptionWithResponse => e
      raise e
    end

    def patch(url, payload)
      response = RestClient.patch(url, payload.to_json, { **api_headers })
      response
    rescue RestClient::ExceptionWithResponse => e
      raise e
    end

    def delete(url)
      response = RestClient.delete(url, { **api_headers })
      response
    rescue RestClient::ExceptionWithResponse => e
      raise e
    end

    protected

    def api_headers
      {
        accept: "application/json",
        content_type: "application/json",
        authorization: "Bearer #{ENV["STRIPE_API_KEY"]}"
      }
    end
  end
end
