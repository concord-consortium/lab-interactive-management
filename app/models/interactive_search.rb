class InteractiveSearch < ActiveRecord::Base

  def interactives
    @interactives ||= find_interactives
  end

  def find_interactives
    @interactives = Interactive.joins(:group).where('groups.category' => self.group_category)

    if @interactives.empty?
      @interactives = Interactive.joins(:group).where('groups.name' => self.group_name)
    else
      @interactives = @interactives.joins(:group).where('groups.name' => self.group_name) if self.group_name.present?
    end
    find_hstore(:publicationStatus)
    find_hstore(:title)
    find_hstore(:subtitle)
    find_hstore(:about)
    @interactives
  end

  private

  def find_hstore(attr_name)
    attr_value = send(attr_name)
    return if attr_value.blank?
    where_clause = "json_rep -> '#{attr_name}' LIKE '%#{attr_value}%'"
    @interactives = @interactives.empty? ? Interactive.where(where_clause) :  @interactives.where(where_clause)
  end
end
