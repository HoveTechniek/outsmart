# frozen_string_literal: true

module Outsmart
  class WorkordersResource < Resource
    def initialize(client)
      @outsmart_url = 'GetWorkorders'
      @dashboard_class = Workorder
      @outsmart_id = 'Id'
      @searchable = true

      super(client)
    end

    def where(status:, update_status: false, **filters)
      params = { status:, update_status: }

      filters.each_with_index do |(k, v), i|
        params.merge!({
                        "key[#{i}]": k,
                        "value[#{i}]": v,
                        "operator[#{i}]": 'eq'
                      })
      end

      response = get_request(outsmart_url, params:)
      Collection.from_response(response, key: 'response', type: @dashboard_class)
    end
  end
end
