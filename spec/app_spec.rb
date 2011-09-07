require File.dirname(__FILE__) + '/spec_helper'

describe 'App' do
  include Rack::Test::Methods

  def app
    AgileCircleApp
  end

  it 'should run a simple test' do
    get '/'
    last_response.status.should == 200
    last_response.body.should match /Hello AgileCircle!/
  end
end