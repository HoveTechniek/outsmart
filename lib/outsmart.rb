# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'
require 'json'
require 'outsmart/version'
require 'outsmart/engine'

module Outsmart
  mattr_accessor :token, :software_token

  autoload :Client,   'outsmart/client'
  autoload :Error,    'outsmart/error'
  autoload :Object,   'outsmart/object'
  autoload :Resource, 'outsmart/resource'
  autoload :Collection, 'outsmart/collection'

  autoload :EmployeesResource, 'outsmart/resources/employees_resource'
  autoload :CustomersResource, 'outsmart/resources/customers_resource'
  autoload :ProjectsResource, 'outsmart/resources/projects_resource'
  autoload :WorkordersResource, 'outsmart/resources/workorders_resource'

  autoload :Employee, 'outsmart/objects/employee'
  autoload :Customer, 'outsmart/objects/customer'
  autoload :Project, 'outsmart/objects/project'
  autoload :Workorder, 'outsmart/objects/Workorder'
end

# module Outsmart::Outsmart
# autoload :Client, 'outsmart/client'

# class Outsmart
#   BASE_URL = 'https://www.werkbonapp.nl/openapi/8/'
#   Faraday.default_adapter = :net_http

#   def response(action)
#     JSON.parse(client.get(action).body, { symbolize_names: true })
#   end

#   def workorders(status = 'Compleet')
#     @workorders ||= JSON.parse(client.get('GetWorkorders') do |req|
#       req.params['status'] = status
#       req.params['update_status'] = false
#     end.body, { symbolize_names: true })[:response]

#     @workorders.select { |workorder| workorder[:Archived] == '0' }
#   end

#   def employees
#     @employees ||= response('employees')[:response]
#   end

#   def employee(number)
#     employees.select { |employee| employee[:number] == number.to_s }[0]
#   end

#   def client
#     @client ||= Faraday.new(
#       url: BASE_URL,
#       params: { token: credentials[:token], software_token: credentials[:software_token] },
#       headers: { 'Content-Type' => 'application/json' }
#     ) do |faraday|
#       faraday.response :logger # log requests and responses to $stdout
#     end
#   end

#   private

#   def credentials
#     Rails.application.credentials.owa
#   end
# end
# end
