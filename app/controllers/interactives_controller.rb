class InteractivesController < ApplicationController
  before_action :set_interactive, only: [:show, :edit, :update, :destroy]

  def index
    groups = Group.all.map do |g|
      {
        'id' =>  g.path, 'path' =>  g.path, 'name' => g.name, 'category' => g.category,
        'location' => url_helper.group_path(g)
      }
    end

    interactives = Interactive.all.map do |i|
      {
        'id' => i.path, 'title' => i.title, 'path' => "webapp/interactives/#{i.path}", 'groupKey' => i.groupKey,
        'subtitle' => i.subtitle, 'about' => i.about, 'publicationStatus' => i.publicationStatus,
        'location' =>   url_helper.interactive_path(i)
      }
    end
    render :json => {
      'interactives'  => interactives,
      'groups'        => groups
    }
  end

  def show
    if @interactive
      render :json => presenter
    else
      render :json => {:errors => "Interactive with path = \"#{params[:id]}\" not found"}, :status => :unprocessable_entity
#      render :json 'i', :status => :unprocessable_entity
    end
  end

  # def group_list
  #   interactives = Interactive.all.collect do |i|
  #      presenter(i).group_listing
  #   end
  #   render :json => interactives
  # end

  # def create
  #   group = Group.find(params[:interactive][:groupKey])
  #   create_path_and_id(group)

  #   @interactive = Interactive.new(params[:interactive])
  #   @interactive.group = group

  #   interactive_model = create_interactive_model
  #   @interactive.interactive_models << interactive_model

  #   if @interactive.save
  #     render({
  #       :json     => presenter(@interactive).runtime_properties,
  #       :status   => :created,
  #       :location => interactive_path(@interactive)
  #     })
  #   else
  #     render({
  #       :json => @interactive.errors.messages,
  #       :status => :unprocessable_entity
  #     })
  #   end
  # end

  # def update
  #   @interactive = Interactive.find(params[:id])

  #   if @interactive.update_attributes(params[:interactive]) &&  @interactive.update_interactive_models(params[:interactive][:models])
  #     render({
  #       :json     => presenter(@interactive).runtime_properties,
  #       :status   => :created,
  #       :location => interactive_path(@interactive)
  #     })
  #   else
  #     render({
  #       :json => @interactive.errors,
  #       :status => :unprocessable_entity
  #     })

  #   end
  # end

  # private
  # def presenter(model=nil)
  #   model ||= Interactive.get(params[:id])
  #   Presenters::Interactive.new(model)
  # end

  # # TODO: refactor this and Parsers#Interactive#generate_couch_doc_id
  # # into the Interactive model
  # def create_path_and_id(group)
  #   groupKey = group.path.gsub('/','_')
  #   title = params[:interactive][:title].gsub(' ', '_')

  #   params[:interactive][:id] = "interactives_#{groupKey}_#{title}"
  #   params[:interactive][:path] = "webapp/interactives/#{params[:interactive][:id]}"

  # end

  # def create_interactive_model
  #   interactive_model = InteractiveModel.new(:viewOptions => params[:interactive][:models].first[:viewOptions],
  #                                            :local_ref_id => params[:interactive][:models].first[:id],
  #                                            :parameters => params[:interactive][:parameters],
  #                                            :outputs => params[:interactive][:outputs],
  #                                            :filteredOutputs => params[:interactive][:filteredOutputs],
  #                                            :modelOptions => params[:interactive][:models].first[:modelOptions] )
  #   interactive_model.md2d = create_model
  #   interactive_model.save!
  #   interactive_model
  # end

  # def create_model
  #   orig_model_url = params[:interactive][:models].first[:url]
  #   model_id = orig_model_url.split('/').last.gsub('.json','')
  #   old_model = Models::Md2d.find(model_id)
  #   old_model.clone! do |m|
  #     m.from_import = false
  #     m.name = nil
  #     m.url = ::Models::Md2d.generate_url(m.id)
  #   end
  # end
  private

  def set_interactive
    @interactive = Interactive.find_by_path(params[:id])
  end

  def presenter
    presenter_hash = {'id' => @interactive.path }
    # don't include the interactive's serialized attribute
    presenter_hash.merge!(@interactive.ordered_attributes.delete('json_rep'))

    # Two options here to get a representation of this interactive's models
    # 1 - get the values, in json_rep['models'] that was set from the interactive JSON file
    # when this interactive was created.
    # OR
    # 2 - get the values interactive_models associated with this interactive.
    # Doing #2
    presenter_hash['models'] = @interactive.interactive_models.map do |im|
      # find the 'local' hash for this model in the json_rep attribute
      json_rep_model = @interactive.json_rep['models'].find { |m| m['url'] == im.model.url }

      {
        'type' => im.model.json_rep['type'],
        'url' => url_helper.models_md2d_path(im.model.url),
        'id' => im.model.url,
        # not all of viewOptions are needed for the interactive
        # return what was in the JSON file for this interactive
        'viewOptions' => json_rep_model['viewOptions']
        # TODO: lets fix this. maybe have two fields in the md2d model?
        # 'viewOptions' => im.model.viewOptions
      }
    end
    presenter_hash
  end
end
