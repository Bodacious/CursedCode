module Acme
  module Products
    require_relative "../connection"
    require 'pry'
    class Update
      extend Forwardable
      ENDPOINT = "products/%<id>s".freeze

      attr_reader :connection
      def_delegator :connection, :patch

      def initialize(connection = Acme::Connection.new)
        @connection = connection
      end

      def self.call(id, **data)
        request_path = format(ENDPOINT, id: id)
        # binding.pry
        new.patch(request_path, **data).body
      end
    end
  end
end
