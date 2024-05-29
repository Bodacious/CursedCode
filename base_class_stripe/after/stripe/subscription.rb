# frozen_string_literal: true

require_relative 'api_client'

module Stripe
  class Subscription
    SUBSCRIPTION_BASE_URL = '/v1/subscriptions'

    attr_reader :api_client

    def initialize(api_client = APIClient.new)
      @api_client = api_client
    end

    def create(customer, price)
      attributes = { customer: customer, items: [{ price: price }] }

      response = api_client.post(SUBSCRIPTION_BASE_URL, attributes)

      JSON.parse(response)
    end

    def fetch_one(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

      response = api_client.get(endpoint)

      JSON.parse(response)
    end

    def resume(id, _attributes)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

      response = api_client.post(endpoint, { billing_cycle_anchor: 'now' })

      JSON.parse(response)
    end

    def cancel(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

      response = api_client.delete(endpoint)

      JSON.parse(response)
    end
  end
end
