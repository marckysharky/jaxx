require 'spec_helper'

describe Jaxx do
  
  it ".upload" do
    upload = double 'upload'
    Jaxx::Upload.should_receive(:new).and_return(upload)
    upload.should_receive(:execute)
    Jaxx.upload
  end

  it ".upload" do
    download = double 'download'
    Jaxx::Download.should_receive(:new).and_return(download)
    download.should_receive(:execute)
    Jaxx.download
  end

  describe ".environment" do
    it "returns instance of Jaxx::Environment" do
      Jaxx.environment.should be_kind_of(Jaxx::Environment)
    end
  end
end
