Given /^the local authentication resource is available$/ do
  stub_credentials_service
  Fog.mock!
end

Then /^the access key and access secret should not be empty$/ do
  Jaxx.environment.credentials[:access_key].should_not be_empty
  Jaxx.environment.credentials[:access_secret].should_not be_empty
end

Given /^the file "(.*?)" exists$/ do |f| 
  File.open f, 'w+'
end

Then /^the file should be uploaded$/ do
end
