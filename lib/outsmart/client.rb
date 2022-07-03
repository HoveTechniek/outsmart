# frozen_string_literal: true

module Outsmart
  class Client
    BASE_URL = 'https://www.werkbonapp.nl/openapi/8/'

    def initialize(token: nil, software_token: nil, adapter: Faraday.default_adapter)
      @token          = token || Rails.application.credentials.dig(:owa, :token)
      @software_token = software_token || Rails.application.credentials.dig(:owa, :software_token)
      @adapter        = adapter
    end

    def connection
      @connection ||= Faraday.new(
        BASE_URL,
        params: { token: @token, software_token: @software_token },
        headers: { 'Content-Type' => 'application/json' }
      ) do |faraday|
        faraday.response :logger
      end
    end

    def employees
      EmployeesResource.new(self)
    end

    def customers
      CustomersResource.new(self)
    end

    def projects
      ProjectsResource.new(self)
    end

    def workorders
      WorkordersResource.new(self)
    end
  end
end
