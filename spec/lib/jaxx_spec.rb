require 'spec_helper'

describe Jaxx do

  describe ".save" do
 
    it "creates a new transaction" do
      trans = double 'trans', :process => true
      Jaxx::Transaction.should_receive(:new).and_return(trans)
      Jaxx.save
    end

  end

  describe ".environment" do
    it "returns instance of Jaxx::Environment" do
      Jaxx.environment.should be_kind_of(Jaxx::Environment)
    end
  end
end
