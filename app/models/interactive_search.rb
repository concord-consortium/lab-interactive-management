class InteractiveSearch < ActiveRecord::Base

  def interactives
    @interactives ||= find_interactives
  end

  def find_interactives
    @interactives = Interactive.joins(:group).where('groups.category' => self.group_category)
    if @interactives.empty?
      @interactives = Interactive.joins(:group).where('groups.name' => self.group_name)
    else
      # @interactives = @interactives.joins(:group).where('groups.name' => self.group_name) if self.group_name.present?
      @interactives = @interactives.joins(:group).where('groups.name' => self.group_name)
    end

    interactive_method("json_rep -> 'publicationStatus' LIKE '%#{self.publicationStatus}%'")
    interactive_method("json_rep -> 'title' LIKE '%#{self.title}%'")
    interactive_method("json_rep -> 'subtitle' LIKE '%#{self.subtitle}%'")
    interactive_method("json_rep -> 'about' LIKE '%#{self.about}%'")
  end

  private

  def interactive_method(where_clause)
    @interactives = @interactives.empty? ? Interactive.where(where_clause) :  @interactives.where(where_clause)
  end
end
