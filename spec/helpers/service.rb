require 'fakeweb'

module ServiceHelper

  def stub_credentials_service
    Fog::Compute::AWS.stub(:fetch_credentials).and_return({
      :aws_access_key_id     => 'foo',
      :aws_secret_access_key => 'bar',
      :aws_session_token     => 'foobar'
    })
  end

end
