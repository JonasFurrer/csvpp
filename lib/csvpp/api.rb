require 'sinatra/base'

module CSVPP
  class API < Sinatra::Base
    post '/parse' do
      input_format = params['format']
      input = params['input']
      require 'pry'; binding.pry
    end
  end
end
