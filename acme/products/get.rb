module Acme
  module Products
    require_relative "../base"
    class Get < Base
      ENDPOINT = "products/%<id>s".freeze
      def self.call(id, **params)
        request_path = format(ENDPOINT, id: id)
        new.get(request_path, **params)
      end
    end
  end
end
