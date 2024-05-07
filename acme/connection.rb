module Acme
  require 'delegate'
  require "faraday"
  class Connection < DelegateClass(Faraday)
    API_BASE_URL = "https://dummyjson.com/".freeze
    def initialize
      faraday_connection = Faraday.new(API_BASE_URL) do |config|
        config.request(:json)
        config.response(:json)
      end
      super(faraday_connection)
    end
  end
end