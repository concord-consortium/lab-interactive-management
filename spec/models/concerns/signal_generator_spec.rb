# -*- coding: utf-8 -*-
require 'spec_helper'
WebMock.allow_net_connect!

############################
# THIS TEST ASSUMES THAT INTERACTIVE AND MODELS JSON FILES ARE
# AVAILABLE AT localhost:3000
# in the lab repo run:
# bin/rackup config.ru -p 3000
#############################

describe Parser::Interactive do
  # This is the hash thats kept in the interactives.json for this interactive
  let(:interactive_hash) do
    {
      "title" => "Signal Generator",
      "path" =>  "interactives/signal-generator/signal-generator.json",
      "groupKey" => "signal-generator",
      "subtitle" =>  "Testing the Signal Generator model type",
      "about" =>  "",
      "publicationStatus" =>  "draft"
    }
  end

  describe "#create_model" do
    subject do
      # create the Interactive Rails model
      Parser::Interactive.new('http://127.0.0.1:3000', interactive_hash).create_model
    end

    it "should create one Interactive Rails Model" do
      subject
      Interactive.count.should == 1
    end
    # interactive properties from either the interactives.json OR
    # the json for this pendulum interactive JSON file
    its(:title) { should == 'Signal Generator'}
    its(:path) {should == "interactives_signal-generator_signal-generator" }
    its(:group_key) { should == "signal-generator"}
    its(:subtitle) { should == "Testing the Signal Generator model type" }
    its(:about)  do
      should ==  ""
    end
    its(:publicationStatus) { should == 'draft'}

    # interactive properties defined in the pendulum interactive JSON file
    # its(:fontScale) { should == 0.8 }
    its(:models) do
      should == [{
                   "type" =>  "signal-generator",
                   "id" =>  "signal1",
                   "url" =>  "models_signal-generator_signal-generator",
                   "viewOptions" =>  {
                     "controlButtons" => "play_reset",
                     "showClock" => true
                   }
                 }]
    end

    its(:layout) do
      should == {
        "below-model" => ["propertiesGraph" ]
      }
    end

    it "should create no Md2d models" do
      subject.md2ds.should have(0).md2d
      Md2d.count.should == 0
    end

    it "should create one SignalGenerator model" do
      subject.signal_generators.should have(1).signal_generator
      SignalGenerator.count.should == 1
    end

    it "should create a SignalGenerator with the correct viewOptions" do
      subject.signal_generators.first.viewOptions.should == { "controlButtons"=>"play_reset", "showClock"=> true }
    end

  end
end
