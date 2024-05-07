module Acme
  # @see https://dummyjson.com
  class Base
    require "faraday"

    class Error < StandardError; end

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

    def make_request(verb, path, **params_or_data)
      uri = URI.join(API_BASE_URL, path)
      response = Faraday.public_send(verb, uri, **params_or_data)
      if response.success?
        JSON.parse(response.body)
      else
        raise Error, response.body
      end
    end
  end
end
