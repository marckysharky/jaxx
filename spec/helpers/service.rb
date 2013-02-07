require 'fakeweb'
require 'jaxx/about_me'

module ServiceHelper

  def stub_credentials_service
    Fog::Compute::AWS.stub(:fetch_credentials).and_return({
      :aws_access_key_id     => 'foo',
      :aws_secret_access_key => 'bar',
      :aws_session_token     => 'foobar'
    })
  end

  def stub_meta_request path, body
    uri = if path.kind_of?(String)
      URI::HTTP.build(:host => Jaxx::AboutMe.host, :path => [Jaxx::AboutMe.base_path, path].join('/'))  
    else
      path
    end
    FakeWeb.register_uri :get, uri, :body => body 
  end

  def stub_meta_request_by_method meth, body
    path = meth.to_s.gsub('_', '-')
    stub_meta_request path, body
  end

  def ensure_api_response meth, expected_response = "", path = nil
    if path
      stub_meta_request path, expected_response
    else
      stub_meta_request_by_method meth, expected_response
    end

    subject.send(meth).should == expected_response
  end
end
