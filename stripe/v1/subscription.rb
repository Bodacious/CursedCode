require "stripe/base"

module Stripe
  class Subscription < Base
    SUBSCRIPTION_BASE_URL = "#{BASE_URL}/v1/subscriptions"

    def create(customer, price)
      attributes = { customer:, items: [{ price: }] }

      response = post(SUBSCRIPTION_BASE_URL, attributes)

      JSON.parse(response)
    end

    def fetch_one(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join("/")

      response = get(endpoint)

      JSON.parse(response)
    end

    def resume(id, attributes)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join("/")

      response = post(endpoint, { billing_cycle_anchor: "now" })

      JSON.parse(response)
    end

    def cancel(id)
      endpoint = [SUBSCRIPTION_BASE_URL, id].join("/")

      delete(endpoint)
    end
  end
end
