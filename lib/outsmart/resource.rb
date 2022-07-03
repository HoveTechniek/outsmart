# frozen_string_literal: true

module Outsmart
  class Resource
    attr_reader :client, :outsmart_url, :dashboard_class, :outsmart_id, :searchable

    def initialize(client)
      @client = client
    end

    def find(attribute)
      if @searchable
        params = { key: @outsmart_id, value: attribute, operator: 'eq' }
        result = JSON.parse(get_request(@outsmart_url, params:).body)['response'][0]
      else
        request = get_request(@outsmart_url).body
        parsed_response = JSON.parse(request)['response']
        result = parsed_response.select { |record| record[@outsmart_id.to_s].to_s == attribute.to_s }[0]
      end

      dashboard_class.new(result)
    end

    def where(**params)
      list(**params)
    end

    def all
      where
    end

    def list(**filters)
      response = get_request(outsmart_url, params: format_search_params(filters:))
      Collection.from_response(response, key: 'response', type: @dashboard_class)
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body.to_json, headers)
    end

    def patch_request(url, body:, headers: {})
      puts url
      puts body
      handle_response client.connection.patch(url, body.to_json, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body.to_json, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body['error']}"
      when 404
        raise Error, "404: #{response.body['error']}"
      when 1000..1001
        raise Error, "Geen resource op deze url #{response.body['error']}"
      end
      response
    end

    def format_search_params(**filters)
      params = {}
      filters[:filters].each_with_index do |(k, v), i|
        params.merge!({
                        "key[#{i}]": k,
                        "value[#{i}]": value(v),
                        "operator[#{i}]": operator(v)
                      })
      end
      params
    end

    def value(value)
      return value[0] if value[0].instance_of?(String)

      value
    end

    def operator(value)
      return value[1] if value[1].instance_of?(String)

      'eq'
    end
  end
end
