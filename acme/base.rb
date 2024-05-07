module Acme
  # @see https://dummyjson.com
  class Base
    require "faraday"

    API_BASE_URL = "https://dummyjson.com/".freeze

    def get(path, **params)
      make_request(:get, path, **params)
    end

    def post(path, **data)
      make_request(:post, path, **data)
    end

    def patch(path, **data)
      make_request(:patch, path, **data)
    end

    def delete(path, **params)
      make_request(:delete, path, **params)
    end

    private

    def faraday_connection
      @faraday_connection ||= Faraday.new(API_BASE_URL) do |config|
        config.request(:json)
        config.response(:json)
      end
    end

    def make_request(verb, path, **params_or_data)
      uri = URI.join(API_BASE_URL, path)
      response = faraday_connection.public_send(verb, uri, **params_or_data)
      response.body
    end
  end
end
