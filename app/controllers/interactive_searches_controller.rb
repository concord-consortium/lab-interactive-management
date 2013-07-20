class InteractiveSearchesController < ApplicationController

  before_action :publication_statuses, only: [:new, :show]

  def new
    @interactive_search = InteractiveSearch.new
  end

  def create
    @interactive_search = InteractiveSearch.create!(params[:interactive_search].permit!)
    redirect_to @interactive_search
  end

  def show
    search_result = InteractiveSearch.find(params[:id])
    @interactive_search = InteractiveSearch.new(:title => search_result.title, :subtitle => search_result.subtitle, :about => search_result.about, :group_name => search_result.group_name, :group_category => search_result.group_category, :publicationStatus => search_result.publicationStatus)
    @interactives =  search_result.interactives.page(params[:page]).per_page(15)
  end

  private

  def publication_statuses
    @publication_statuses ||= Interactive.where('json_rep ? :key', :key => 'publicationStatus').map(&:publicationStatus).uniq.map{ |p| [p, p]}
  end
end
