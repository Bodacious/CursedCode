# frozen_string_literal: true

require 'rest-client'

module Stripe
  class Base
    BASE_URL = 'https://api.stripe.com'

    def post(url, payload)
      RestClient.post(url, payload.to_json, { **api_headers })
    rescue RestClient::ExceptionWithResponse => e
      puts 'API Error'
      raise e
    end

    def get(url, params: {})
      RestClient.get(url, { **api_headers, params: })
    rescue RestClient::ExceptionWithResponse => e
      puts 'API Error'
      raise e
    end

    def patch(url, payload)
      RestClient.patch(url, payload.to_json, { **api_headers })
    rescue RestClient::ExceptionWithResponse => e
      puts 'API Error'
      raise e
    end

    def delete(url)
      RestClient.delete(url, { **api_headers })
    rescue RestClient::ExceptionWithResponse => e
      puts 'API Error'
      raise e
    end

    protected

    def api_headers
      {
        accept: 'application/json',
        content_type: 'application/json',
        authorization: "Bearer #{ENV.fetch('STRIPE_API_KEY', nil)}"
      }
    end
  end
end
