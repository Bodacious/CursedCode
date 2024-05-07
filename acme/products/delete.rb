module Acme
  module Products
    require_relative "../connection"
    class Delete
      ENDPOINT = "products/%<id>s".freeze
      extend Forwardable

      attr_reader :connection
      def_delegator :connection, :delete

      def initialize(connection = Acme::Connection.new)
        @connection = connection
      end

      def self.call(id)
        request_path = format(ENDPOINT, id: id)
        new.delete(request_path).body
      end
    end
  end
end
