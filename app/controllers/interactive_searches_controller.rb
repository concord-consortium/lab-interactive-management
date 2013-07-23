class InteractiveSearchesController < ApplicationController

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

end
