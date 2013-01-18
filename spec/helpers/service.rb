module ServiceHelper

  def stub_credentials_service
    FakeWeb.register_uri :get, 
      /#{Jaxx.environment.service_domain}#{Jaxx.environment.service_path}/, 
      :body => '{"AccessKeyId" : "foo", "SecretAccessKey" : "bar", "Code" : "Success"}'
  end

end
