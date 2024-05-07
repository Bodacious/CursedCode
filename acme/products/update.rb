module Acme
  module Products
    require_relative "../base"
    class Update < Base
      ENDPOINT = "products/%<id>s".freeze
      def self.call(id, **data)
        request_path = format(ENDPOINT, id: id)
        new.patch(request_path, **data)
      end
    end
  end
end
