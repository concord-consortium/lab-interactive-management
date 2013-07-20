# -*- coding: utf-8 -*-
require 'spec_helper'

describe Interactive do

  let(:group) { create(:inquiry_pendulum) }

  describe "#create 2" do
    before(:each) do
      Interactive.create!(build(:pendulum).attributes)
    end

    it "should create the join model" do
      i = Interactive.first
      m = Md2d.new(build(:md2d_pendulum0).attributes)
      i.md2ds << m
      i.save!
      i.md2ds.should have(1).md2ds
    end
  end


  describe "#create" do
    subject {  create(:pendulum) }

    it "should create one interactive" do
      subject
      Interactive.count.should == 1
    end

    its(:revision) { should == "1.2.1" }
    it "should have the title 'Pendulum'" do
      subject.title.should == "Pendulum"
    end
    it "should have a public publicationStatus" do
      subject.publicationStatus.should == "public"
    end
    it "should be part of the 'Inquiry Space: Pendulums' group" do
      subject.group.name.should == "Inquiry Space: Pendulums"
    end

    it "should belong to one group" do
      subject
      Group.first.name == subject.group.name
      Group.first.revision.should == subject.group.revision
    end

    it "should have one model" do
      subject.should have(1).md2ds
    end
    it "should have the correct gravitational field" do
      subject.md2ds.first.gravitationalField.should == 9.8e-8
    end

    describe "with a generated path" do
      before(:each) do
        subject.gen_new_path
      end
      its(:path) { should == "interactives_inquiry-space_pendulum_1-pendulum" }
    end
  end
end
