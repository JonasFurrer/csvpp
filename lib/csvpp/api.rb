require 'sinatra/base'

module CSVPP
  class API < Sinatra::Base
    post '/parse' do
      content_type :json

      format = params['format']
      input = params['input']

      CSVPP.json(input: input, format: format)
    end
  end
end
