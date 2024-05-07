module Acme
  module Products
    require_relative "../base"
    class List < Base
      ENDPOINT = "products".freeze
      def self.call(**params)
        new.get(ENDPOINT, **params)
      end
    end
  end
end
