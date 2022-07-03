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
