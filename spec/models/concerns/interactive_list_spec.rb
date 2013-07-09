# -*- coding: utf-8 -*-
require 'spec_helper'
WebMock.allow_net_connect!

describe 'parsing the interactives.json file' do

  before(:all) do
    #    @parser = Parser::InteractiveList.new('http://lab.dev.concord.org', 'interactives.json')
    @parser = Parser::InteractiveList.new('http://127.0.0.1:3000', 'interactives.json')
    @parser.parse
  end

  after(:all) do
    Group.delete_all
    Interactive.delete_all
    Md2d.delete_all
    InteractiveModel.delete_all
  end

  it 'should have lots of groups' do
    Group.count.should >= 37
  end

  it 'should have lots of interactives' do
    Interactive.count.should > 600
  end

  it 'should have lots of md2d models' do
    Md2d.count.should > 600
  end

  it 'should have lots of interactive_model models' do
    InteractiveModel.count.should  >= Md2d.count
  end

  describe 'Group: Inquiry Space for Penudulums' do
    subject {Group.find_by_path("inquiry-space/pendulum") }
    it "should have 3 interactives" do
      subject.name.should == "Inquiry Space: Pendulums"
      subject.category.should == "Curriculum"
      subject.path.should == "inquiry-space/pendulum"
      subject.should have(3).interactives
    end
  end

  describe "pendulum interactive" do
    subject { Group.find_by_path("inquiry-space/pendulum").interactives.first }

    it "should have the correct attributes" do
      # contained in the interactives.json file
      subject.title.should == 'Pendulum'
      subject.path.should == "interactives_inquiry-space_pendulum_1-pendulum"
      subject.subtitle.should == "Explore some factors that affect the period of a pendulum."
      subject.publicationStatus.should == "public"
      # contained in the pendulum interactive json file
      subject.fontScale.should == 0.8
      subject.template.should === "wide-right"
      subject.outputs.should == [{"name"=>"currentAngle", "unitAbbreviation"=>'°', "label"=>"Angle", "value"=>["var a0 = getAtomProperties(0),", "    a1 = getAtomProperties(1);", "return Math.atan2(-Math.abs(a1.y-a0.y), a1.x-a0.x) * rad2deg + 90;"]}]

    end

    it "should have the correct path" do
      subject.path.should == "interactives_inquiry-space_pendulum_1-pendulum"
    end

    it "should have one md2d model" do
      subject.should have(1).md2ds
    end

    describe 'pendulum model' do
      subject { Group.find_by_path("inquiry-space/pendulum").interactives.first.md2ds.first }
      it "should have the correct attributes" do
        # contained in the pendulum interactive json file
        subject.url.should == "imports_legacy-mw-content_converted_inquiry-space_pendulum_pendulum1_0"
        subject.viewOptions.should == {"viewPortWidth"=>5, "viewPortHeight"=>3, "viewPortZoom"=>1, "viewPortX"=>0, "viewPortY"=>0, "viewPortDrag" => false, "backgroundColor"=>"#eeeeee", "showClock"=>true, "markColor"=>"#f8b500", "keShading"=>false, "chargeShading"=>false, "useThreeLetterCode"=>true, "aminoAcidColorScheme"=>"hydrophobicity", "showChargeSymbols"=>true, "showVDWLines"=>false, "VDWLinesCutoff"=>"medium", "showVelocityVectors"=>false, "showForceVectors"=>false, "showAtomTrace"=>false, "images"=>[], "imageMapping"=>{}, "textBoxes"=>[], "xlabel"=>false, "ylabel"=>false, "xunits"=>false, "yunits"=>false, "controlButtons"=>"play", "gridLines"=>false, "atomNumbers"=>false, "enableAtomTooltips"=>false, "enableKeyboardHandlers"=>true, "atomTraceColor"=>"#6913c5", "velocityVectors"=>{"color"=>"#000", "width"=>0.01, "length"=>2}, "forceVectors"=>{"color"=>"#169C30", "width"=>0.01, "length"=>2}}        # contained in the pendulum1$0 md2d json file
        subject.unitsScheme.should == 'md2d'
        subject.timeStepsPerTick.should == 50
      end
    end
  end
end
