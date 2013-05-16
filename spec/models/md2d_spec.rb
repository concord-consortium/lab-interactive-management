require 'spec_helper'

describe Md2d do

  let( :md2d_hash) do
  end

  describe '#create' do
    subject { create(:md2d_pendulum0) }

    its(:revision) { should == "1.2.1" }
    it "should have a 'md2d' type" do
      subject._type.should == 'md2d'
    end

    it "should have a 'viewPortWidth'of 5" do
      subject.viewOptions['viewPortWidth'].should == 5
    end
  end
end
