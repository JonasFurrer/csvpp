require 'sinatra/base'

module CSVPP
  class API < Sinatra::Base
    before do
      headers 'Access-Control-Allow-Origin' => '*'

      content_type :json
    end

    post '/parse' do
      body = Oj.load(request.body.read)
      input = body.fetch('input')
      format = body.fetch('format')

      CSVPP.json(input: input, format: format)
    end

    options "*" do
      response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
      200
    end
  end
end
