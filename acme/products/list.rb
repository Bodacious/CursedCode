module Acme

  module Products
    class List
      require_relative '../connection'

      extend Forwardable

      ENDPOINT = "products".freeze

      attr_reader :connection
      def_delegator :connection, :get

      def initialize(connection = Acme::Connection.new)
        @connection = connection
      end
      def self.call(**params)
        new.get(ENDPOINT, **params).body
      end
    end
  end
end
