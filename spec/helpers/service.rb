module ServiceHelper

  def stub_credentials_service
    sock = double 'sock', :close => true
    TCPSocket.stub(:new).and_return(sock)
    FakeWeb.register_uri :get, /#{Jaxx.environment.service_domain}/, :body => '{"AccessKeyId" : "foo", "SecretAccessKey" : "bar"}'
  end

end
