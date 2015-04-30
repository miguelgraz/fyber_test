require "spec_helper"

describe FyberCli do
  it "has a form to input custom parameters" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('Custom Parameter (pub0)')
  end

  it "stores the informed custom parameters" do
    expect(FyberCli::PARAMS[:uid]).to be_nil
    post '/custom_params', {uid: 'player5', pub0: 'campaign5', page: 5}
    expect(FyberCli::PARAMS[:uid]).to eq 'player5'
  end

  it "receives custom parameters and does the request" do
    post '/custom_params', {uid: 'player5', pub0: 'campaign5', page: 5}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.path).to eq('/request')
    expect(last_response.body).to include('Title:')
  end

  it "expects correct parameters if something's wrong" do
    FyberCli::PARAMS[:uid] = nil
    get '/request'
    expect(last_response.body).to include('Custom Parameter (pub0)')
    expect(last_response.body).to include('An invalid user id (uid) was given as a parameter in the request')
  end
end
