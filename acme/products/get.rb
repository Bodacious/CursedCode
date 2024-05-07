module Acme
  module Products
    require_relative "../connection"
    class Get
      extend Forwardable
      ENDPOINT = "products/%<id>s".freeze

      attr_reader :connection
      def_delegator :connection, :get

      def initialize(connection = Acme::Connection.new)
        @connection = connection
      end

      def self.call(id, **params)
        request_path = format(ENDPOINT, id: id)
        new.get(request_path, **params).body
      end
    end
  end
end
