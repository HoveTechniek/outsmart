# frozen_string_literal: true

module Outsmart
  class EmployeesResource < Resource
    def initialize(client)
      @outsmart_url = 'employees'
      @dashboard_class = Employee
      @outsmart_id = 'number'

      super(client)
    end
  end
end
