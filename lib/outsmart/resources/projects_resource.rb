# frozen_string_literal: true

module Outsmart
  class ProjectsResource < Resource
    def initialize(client)
      @outsmart_url = 'projects'
      @dashboard_class = Project
      @outsmart_id = 'code'
      @searchable = true

      super(client)
    end

    def create(attributes)
      Project.new post_request('projects', body: attributes)
    end
  end
end
