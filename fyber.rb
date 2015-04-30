require 'sinatra'

class FyberCli < Sinatra::Base
  URL = 'http://api.sponsorpay.com/feed/v1/offers.json'
  APIKey = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
  PARAMS = {
    appid: 157,
    apple_idfa: '2E7CE4B3-F68A-44D9-A923-F4E48D92B31E',
    apple_idfa_tracking_enabled: false,
    device_id: '2b6f0cc904d137be2e1730235f5664094b83',
    format: 'json',
    ip: '109.235.143.113',
    locale: 'de',
    offer_types: 112,
    os_version: '6.0',
    timestamp: Time.now.to_i
  }

  get '/' do
    erb :index
  end

  post '/custom_params' do
    PARAMS[:uid] = params['uid']
    PARAMS[:pub0] = params['pub0']
    PARAMS[:page] = params['page']

    redirect '/request'
  end

  get '/request' do
    uri = URI(URL)
    uri.query = URI.encode_www_form(PARAMS.merge({hashkey: hashkey}))
    res = Net::HTTP.get_response(uri)
    res.body
  end

  def hashkey
    string = ''
    PARAMS.keys.sort_by(&:downcase).each do |key|
      string += "#{key.to_s}=#{PARAMS[key]}&"
    end
    Digest::SHA1.hexdigest(string + APIKey)
  end
end
