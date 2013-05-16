module Parser
  class Group
    attr_reader :group_hash

    def initialize(group_hash)
      @group_hash = group_hash
    end

    def create_model
      ::Group.create!(:json_rep => group_hash, :revision => '0.0.1')
    end
  end
end
