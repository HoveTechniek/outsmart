# frozen_string_literal: true

module Outsmart
  class CustomersResource < Resource
    def initialize(client)
      @outsmart_url = 'relations'
      @dashboard_class = Customer
      @outsmart_id = 'debtor_number'
      @searchable = true

      super(client)
    end
  end
end
