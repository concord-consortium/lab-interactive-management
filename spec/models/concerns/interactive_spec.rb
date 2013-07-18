# -*- coding: utf-8 -*-
require 'spec_helper'
WebMock.allow_net_connect!


describe Parser::Interactive do
  # This is the hash thats kept in the interactives.json for this pendulum interactive
  let(:interactive_hash) do
    {
      "title" => "Pendulum",
      "path" => "interactives/inquiry-space/pendulum/1-pendulum.json",
      "groupKey" => "inquiry-space/pendulum",
      "subtitle" => "Explore some factors that affect the period of a pendulum.",
      "about" => [
                  "Press the play button. Watch the graph to see how the angle of the pendulum changes as it",
                  "swings back and forth. Use the graph to determine the period of the pendulum. Adjust the",
                  "scale by dragging the numbers on the axes. Change each variable â€“ gravity, rod length,",
                  "starting angle and mass â€“ and observe how each one affects the period. Can you explain why?",
                  "Try the damping slider. Does damping change the period?"
                 ],
      "publicationStatus" => "public"
    }
  end

  describe "#create_model" do
    subject do
      # create the Interactive Rails model
      ############################
      # If you set the below to use 127.0.0.1:3000 then this test assumes that
      # interactive and models json files are available at localhost:3000
      # in the lab repo run:
      # bin/rackup config.ru -p 3000
      #############################
      #Parser::Interactive.new('http://127.0.0.1:3000', interactive_hash).create_model

      Parser::Interactive.new("#{Rails.root}/tmp/lab_files", interactive_hash).create_model
      # get the saved Interactive created above
      Interactive.first
    end

    it "should create one Interactive Rails Model" do
      subject
      Interactive.count.should == 1
    end
    # interactive properties from either the interactives.json OR
    # the json for this pendulum interactive JSON file
    its(:title) { should == 'Pendulum'}
    its(:path) {should == "interactives_inquiry-space_pendulum_1-pendulum" }
    its(:group_key) { should == "inquiry-space/pendulum"}
    its(:subtitle) { should == "Explore some factors that affect the period of a pendulum." }
    its(:about)  do
      should ==  ["Press the play button. Watch the graph to see how the angle of the pendulum changes as it", "swings back and forth. Use the graph to determine the period of the pendulum. Adjust the", "scale by dragging the numbers on the axes. Change each variable – gravity, rod length,", "starting angle and mass – and observe how each one affects the period. Can you explain why?", "Try the damping slider. Does damping change the period?"]
    end
    its(:publicationStatus) { should == 'public'}

    # interactive properties defined in the pendulum interactive JSON file
    its(:fontScale) { should == 0.8 }
    its(:models) do
      should == [{"type" => "md2d", "id"=>"pendulum1$0", "url"=>"imports_legacy-mw-content_converted_inquiry-space_pendulum_pendulum1_0", "viewOptions"=>{"controlButtons"=>"play_reset_step", "gridLines"=>true, "showClock"=>true, "velocityVectors"=>{"length"=>10}}, "modelOptions"=>{"unitsScheme"=>"mks", "timeStepsPerTick"=>167, "timeStep"=>1, "modelSampleRate"=>60}, "onLoad"=>["function resetAngle() {", "  set({startingAngle: get('startingAngle')});", "}", "function stopMotion() {", "  stop();", "  setAtomProperties(1, { vx: 0, vy: 0 });", "}", "onPropertyChange('rodLength', resetAngle);", "onPropertyChange('ballMass', resetAngle);", "onPropertyChange('gravitationalField', resetAngle);", "onPropertyChange('damping', resetAngle);", "onPropertyChange('startingAngle', stopMotion);"]}]
    end

    its(:parameters) do
      should ==[{"name"=>"gravity", "label"=>"Gravity", "unitType"=>"acceleration", "onChange"=>"set('gravitationalField', value);", "initialValue"=>9.8}, {"name"=>"rodLength", "label"=>"Rod length", "unitAbbreviation"=>"cm", "onChange"=>"var len = value/100, a0 = getAtomProperties(0), a1 = getAtomProperties(1), angle = Math.atan((a1.x-a0.x)/(a0.y-a1.y)); setRadialBondProperties(0, { length: len }); setAtomProperties(1, {x: a0.x+Math.sin(angle)*len, y: a0.y-Math.cos(angle)*len, vx: 0, vy: 0});", "initialValue"=>100}, {"name"=>"startingAngle", "label"=>"Starting angle", "unitAbbreviation"=>"°", "onChange"=>"var a0 = getAtomProperties(0), angle = value*deg2rad, len = getRadialBondProperties(0).length; setAtomProperties(1, {x: a0.x+Math.sin(angle)*len, y: a0.y-Math.cos(angle)*len, vx: 0, vy: 0});", "initialValue"=>45}, {"name"=>"ballMass", "label"=>"Ball mass", "unitAbbreviation"=>"g", "onChange"=>"setElementProperties(3, { mass: value/1000 });", "initialValue"=>250}, {"name"=>"damping", "label"=>"Damping", "unitType"=>"dampingCoefficient", "onChange"=>"setAtomProperties(1, { friction: value });", "initialValue"=>0}]
    end

    its(:outputs) do
      should ==  [{"name"=>"currentAngle", "unitAbbreviation"=>"°", "label"=>"Angle", "value"=>["var a0 = getAtomProperties(0),", "    a1 = getAtomProperties(1);", "return Math.atan2(-Math.abs(a1.y-a0.y), a1.x-a0.x) * rad2deg + 90;"]}]
    end

    its(:exports) do
      should == {"perRun"=>["gravity", "rodLength", "startingAngle", "ballMass", "damping"], "perTick"=>["currentAngle"]}
    end

    its(:components) do
      should ==  [{"type"=>"slider", "id"=>"gravity-slider", "min"=>0.8, "max"=>19.8, "displayValue"=>"return format('1.1f')(value)", "labels"=>[{"value"=>1, "label"=>"1"}, {"value"=>20, "label"=>"20"}], "steps"=>38, "title"=>"Gravity (m/s²)", "property"=>"gravity"}, {"type"=>"slider", "id"=>"length-slider", "min"=>10, "max"=>200, "displayValue"=>"return format('f')(value)", "labels"=>[{"value"=>10, "label"=>"10 cm"}, {"value"=>200, "label"=>"2 m"}], "steps"=>19, "title"=>"Rod length (cm)", "property"=>"rodLength"}, {"type"=>"slider", "id"=>"angle-slider", "min"=>0, "max"=>90, "displayValue"=>"return format('f')(value)", "labels"=>[{"value"=>0, "label"=>"0"}, {"value"=>90, "label"=>"90"}], "steps"=>45, "title"=>"Starting angle (&deg;)", "property"=>"startingAngle"}, {"type"=>"slider", "id"=>"mass-slider", "min"=>10, "max"=>400, "displayValue"=>"return format('f')(value)", "labels"=>[{"value"=>10, "label"=>"10"}, {"value"=>400, "label"=>"400"}], "steps"=>39, "title"=>"Mass of the ball (g)", "property"=>"ballMass"}, {"type"=>"slider", "id"=>"damping-slider", "min"=>0, "max"=>1, "displayValue"=>"return format('1.2f')(value)", "labels"=>[{"value"=>0, "label"=>"0"}, {"value"=>1.0, "label"=>"1"}], "steps"=>20, "title"=>"Damping (Newton per m/s)", "property"=>"damping"}, {"type"=>"checkbox", "id"=>"velocity-vectors", "text"=>"Show velocity vector", "property"=>"showVelocityVectors"}, {"type"=>"numericOutput", "id"=>"current-angle-display", "property"=>"currentAngle", "displayValue"=>"return format('f')(value)"}, {"type"=>"graph", "id"=>"propertiesGraph", "title"=>"Pendulum Angle", "xlabel"=>"Time  (s)", "ylabel"=>"Angle (°)", "ymin"=>-100, "ymax"=>100, "xmax"=>10, "xTickCount"=>5, "xFormatter"=>"2s", "yFormatter"=>"2s", "properties"=>["currentAngle"]}]
    end

    its(:layout) do
      should == {"right"=>["propertiesGraph"], "bottom"=>[["gravity-slider", "length-slider", "angle-slider"], ["mass-slider", "damping-slider", "velocity-vectors"], ["current-angle-display"]]}
    end

    it "should create 4 Md2d models" do
      subject.md2ds.should have(1).md2d
      Md2d.count.should == 1
    end

    it "should create a Md2d with the imagePath" do
      subject.md2ds.first.imagePath.should == 'imports/legacy-mw-content/converted/inquiry-space/pendulum/'
    end

    it "should create a Md2d with the correct properties" do
      md2d = subject.md2ds.first
      md2d.url.should == "imports_legacy-mw-content_converted_inquiry-space_pendulum_pendulum1_0"
      md2d.viewOptions.should == {"viewPortWidth"=>5, "viewPortHeight"=>3, "viewPortZoom"=>1, "viewPortX"=>0, "viewPortY"=>0, "viewPortDrag" => false, "backgroundColor"=>"#eeeeee", "showClock"=>true, "markColor"=>"#f8b500", "keShading"=>false, "chargeShading"=>false, "useThreeLetterCode"=>true, "aminoAcidColorScheme"=>"hydrophobicity", "showChargeSymbols"=>true, "showVDWLines"=>false, "VDWLinesCutoff"=>"medium", "showVelocityVectors"=>false, "showForceVectors"=>false, "showAtomTrace"=>false, "images"=>[], "imageMapping"=>{}, "textBoxes"=>[], "xlabel"=>false, "ylabel"=>false, "xunits"=>false, "yunits"=>false, "controlButtons"=>"play", "gridLines"=>false, "atomNumbers"=>false, "enableAtomTooltips"=>false, "enableKeyboardHandlers"=>true, "atomTraceColor"=>"#6913c5", "velocityVectors"=>{"color"=>"#000", "width"=>0.01, "length"=>2}, "forceVectors"=>{"color"=>"#169C30", "width"=>0.01, "length"=>2}}
      md2d.gravitationalField.should == 9.8e-8
    end
  end
end
