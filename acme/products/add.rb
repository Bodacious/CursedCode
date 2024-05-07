module Acme
  module Products
    require_relative "../connection"
    class Add
      extend Forwardable

      ENDPOINT = "products/add".freeze

      attr_reader :connection
      def_delegator :connection, :post

      def initialize(connection = Acme::Connection.new)
        @connection = connection
      end

      def self.call(**data)
        new.post(ENDPOINT, **data).body
      end
    end
  end
end
