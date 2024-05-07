module Acme
  module Products
    require_relative "../base"
    class Delete < Base
      ENDPOINT = "products/%<id>s".freeze

      def self.call(id)
        request_path = format(ENDPOINT, id: id)
        new.delete(request_path)
      end
    end
  end
end
