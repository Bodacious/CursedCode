module Acme
  module Products
    require_relative "../base"
    class Add < Base
      ENDPOINT = "products/add".freeze

      def self.call(**data)
        new.post(ENDPOINT, **data)
      end
    end
  end
end
