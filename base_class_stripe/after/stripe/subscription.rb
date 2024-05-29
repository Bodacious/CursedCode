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

      api_client.post(SUBSCRIPTION_BASE_URL, attributes)
    end

    def fetch_one(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

       api_client.get(endpoint)
    end

    def resume(id, _attributes)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

       api_client.post(endpoint, { billing_cycle_anchor: 'now' })
    end

    def cancel(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join('/')

      api_client.delete(endpoint)
    end
  end
end
