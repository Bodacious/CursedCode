# frozen_string_literal: true

require "rest-client"

module Stripe
  class Base
    BASE_URL = "https://api.stripe.com"

    def initialize
      raise(StandardError, "Operation not allowed!") if operation_not_allowed?
    end

    def post(url, payload)
      response = RestClient.post(url, payload.to_json, { **api_headers })

      # Just an example, might not work as it is
      # StripeLogger.info "Created\n- URL: #{url}\n- payload: #{payload}"

      response
    rescue RestClient::ExceptionWithResponse => e
      # Could be handled in a more better and granular way depending on error code

      # Not tested, might not work as it is
      # StripeLogger.error "Create Error\n- URL: #{url}\n- payload: #{options}\nError:\n#{e.message}"

      raise e
    end

    def get(url, params: {}, string_params: false)
      response = RestClient.get(url, { **api_headers, params: })

      # StripeLogger.info "Fetched\n- URL: #{url}\n- params: #{params}"

      response
    rescue RestClient::ExceptionWithResponse => e
      # StripeLogger.error "Fetch Error\n- URL: #{url}\n- params: #{params}\nError:\n#{e.message}"

      raise e
    end

    def patch(url, payload)
      response = RestClient.patch(url, payload.to_json, { **api_headers })

      # StripeLogger.info "Updated\n- URL: #{url}\n- payload: #{payload}"

      response
    rescue RestClient::ExceptionWithResponse => e
      # StripeLogger.error "Update Error\n- URL: #{url}\n- payload: #{options}\nError:\n#{e.message}"

      raise e
    end

    def delete(url)
      response = RestClient.delete(url, { **api_headers })

      # StripeLogger.info "Deleted\n- URL: #{url}"

      response
    rescue RestClient::ExceptionWithResponse => e
      # StripeLogger.error "Delete Error\n- URL: #{url}\nError:\n#{e.message}"

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

    private

    # This is not used normally though, in the past project this was used because there was no staging API and we had to hit the production for testing our integration so after that was done we had to make sure no one calls the API even due to mistake in staging or development
    def operation_not_allowed?
      %w[production test].exclude?(Rails.env)
    end
  end
end
