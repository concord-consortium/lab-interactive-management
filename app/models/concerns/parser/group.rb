module Parser
  class Group
    attr_reader :group_hash

    def initialize(group_hash)
      @group_hash = group_hash
    end

    def create_model
      ::Group.create!(:name => group_hash['name'], :path => group_hash['path'], :category => group_hash['category'], :revision => '0.0.1')
    end
  end
end
