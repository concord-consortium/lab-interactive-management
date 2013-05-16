require 'spec_helper'

describe Group do
  let(:json_hash) do {"path" => "sam/intermolecular-attractions", "name" => "Science of Atoms and Molecules: Intermolecular Attractions", "category" => "Curriculum"}
  end

  subject do
    Group.create!(:json_rep => json_hash, :revision => "1.2.1")
  end

  describe "create!" do
    its(:json_rep) { should == json_hash }
    its(:name) { should == json_hash['name'] }
  end

  describe "find_by_path" do
    before(:each) do
      (1..5).each do |i|
        Group.create!(:json_rep => { 'name' => "Group #{i}", 'path' => "#{Dir.pwd}/group_#{i}", 'category' => "Category #{i}" } )
      end
    end
    it "should find the group" do
      g = Group.find_by_path("#{Dir.pwd}/group_3")
      g.path.should == "#{Dir.pwd}/group_3"
      g.name.should == "Group 3"
      g.category.should == "Category 3"
    end
  end

end
