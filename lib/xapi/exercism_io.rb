require 'faraday'
require 'json'

module Xapi
  class ApiError < StandardError; end

  # ExercismIO encapsulates access to the Exercism API.
  module ExercismIO
    def self.env
      ENV.fetch('RACK_ENV') { 'production' }
    end

    def self.url
      if env == 'production'
        'http://52.10.82.212'
      else
        'http://localhost:4567'
      end
    end

    def self.exercises_for(key)
      request '/api/v1/exercises', key
    end

    def self.code_for(key)
      request('/api/v1/iterations/latest', key)["assignments"]
    end

    def self.conn
      Faraday.new(url: url) do |c|
        c.use Faraday::Adapter::NetHttp
      end
    end

    def self.request(path, key)
      response = conn.get do |req|
        req.url File.join(path)
        req.headers['User-Agent'] = "github.com/exercism/xapi"
        req.params['key'] = key
      end
      intercept JSON.parse(response.body)
    end

    def self.intercept(data)
      fail Xapi::ApiError.new(data['error']) if data['error']

      data
    end
  end
end
