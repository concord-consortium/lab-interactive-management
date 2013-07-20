require 'spec_helper'

describe Group do
  let(:group_hash) do
    {"path" => "sam/intermolecular-attractions", "name" => "Science of Atoms and Molecules: Intermolecular Attractions", "category" => "Curriculum"}
  end

  describe '#create!' do
    subject do
      Group.create!(group_hash.merge(:revision => "1.2.1"))
      Group.first
    end

    its(:name) { should == group_hash['name'] }
    its(:path) { should == group_hash['path'] }
    its(:category) { should == group_hash['category'] }
  end

end
