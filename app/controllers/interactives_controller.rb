class InteractivesController < ApplicationController
  #TODO: remove when we have authentication
  skip_before_filter :verify_authenticity_token

  before_action :set_interactive, only: [:show, :destroy]
  before_action :set_group, only: [:create]

  def index
    @interactives = Interactive.order('id').page(params[:page]).per_page(20)

    respond_to do |format|
      format.html
      format.json do

        groups = Group.all.map do |g|
          {
            'id' =>  g.path, 'path' =>  g.path, 'name' => g.name, 'category' => g.category,
            'location' => url_helper.group_path(g)
          }
        end

        interactives = Interactive.all.map do |i|
          {
            'id' => i.path, 'title' => i.title, 'path' => "interactives/#{i.path}", 'groupKey' => i.group_key,
            'subtitle' => i.subtitle, 'about' => i.about, 'publicationStatus' => i.publicationStatus,
            'location' =>   url_helper.interactive_path(i)
          }
        end
        render :json => {
          'interactives'  => interactives,
          'groups'        => groups
        }
      end
    end
  end

  # works with old interface/application.js
  # def index
  #   groups = Group.all.map do |g|
  #     {
  #       'id' =>  g.path, 'path' =>  g.path, 'name' => g.name, 'category' => g.category,
  #       'location' => url_helper.group_path(g)
  #     }
  #   end

  #   interactives = Interactive.all.map do |i|
  #     {
  #       'id' => i.path, 'title' => i.title, 'path' => "interactives/#{i.path}", 'groupKey' => i.group_key,
  #       'subtitle' => i.subtitle, 'about' => i.about, 'publicationStatus' => i.publicationStatus,
  #       'location' =>   url_helper.interactive_path(i)
  #     }
  #   end
  #   render :json => {
  #     'interactives'  => interactives,
  #     'groups'        => groups
  #   }
  # end

  def show
    respond_to do |format|
      format.html

      format.json do
        if @interactive
          render :json => presenter
        else
          render :json => {:errors => "Interactive with path = \"#{params[:id]}\" not found"}, :status => :unprocessable_entity
        end
      end
    end
  end

  # works with old interface/application.js
  # def show
  #   if @interactive
  #     render :json => presenter
  #   else
  #     render :json => {:errors => "Interactive with path = \"#{params[:id]}\" not found"}, :status => :unprocessable_entity
  #   end
  # end

  def create

    @interactive = Interactive.new(new_interactive_params)
    @interactive.group = @group
    update_models

    if @interactive.save
      render :json => presenter
    else
      render :json => {:errors => @interactive.error}, :status => :forbidden
    end
  end

  def update
    # TODO: determine we should ONLY send the interactive path, not id here.
    @interactive = Interactive.find_by_path(params[:interactive].delete('id'))

    if @interactive.group.path != params[:interactive][:groupKey]
      @interactive.group = Group.find_by_path(params[:interactive][:groupKey])
      params[:interactive][:path] = "interactives_#{params[:interactive][:groupKey]}_#{params[:interactive][:title]}".gsub('$','_').gsub(/^_/,"").gsub('.json','')
    end

    params[:interactive][:group_key] = params[:interactive].delete('groupKey')
    if @interactive.update_attributes(params[:interactive].permit!)
      render :json => presenter
    else
      render :json => {:errors => @interactive.error}, :status => :forbidden
    end
  end
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

  def set_group
    # @group = Group.find_by_path(params[:interactive][:groupKey])
    if @interactive
      @group = @interactive.group
    else
      @group = Group.find_by_path(params[:interactive][:groupKey])
    end
  end

  def set_interactive
    # javascript sends the path as the id
    # html sends the id
    path = params[:id] || params[:interactive][:id]
    @interactive = Interactive.where(:path => path).first || Interactive.find(params[:id])
  end

  def presenter
    presenter_hash = {'id' => @interactive.path, 'from_import' => @interactive.from_import, 'groupKey' => @interactive.group.path }
    # don't include the interactive's serialized attribute

    attrs = @interactive.ordered_attributes
    attrs.delete('json_rep')
    presenter_hash.merge!(attrs)

    model_type = @interactive.model_type

    # Two options here to get a representation of this interactive's models
    # 1 - get the values, in json_rep['models'] that was set from the interactive JSON file
    # when this interactive was created.
    # OR
    # 2 - get the values interactive_models associated with this interactive.
    # Doing #2
    presenter_hash['models'] = @interactive.send(model_type.pluralize.to_sym).map do |model_instance|
      # find the 'local' hash for this model in the json_rep attribute
      json_rep_model = @interactive.json_rep['models'].find { |m| m['url'].match(/#{model_instance.url}/) }

      {
        'type' => model_instance.json_rep['type'],
        'url' => url_helper.model_path(:id => model_instance.url, :model_type => model_type)[1..-1],
        'id' => json_rep_model['id'],
        # not all of viewOptions are needed for the interactive
        # return what was in the JSON file for this interactive
        'viewOptions' => json_rep_model['viewOptions'],
        'modelOptions' => json_rep_model['modelOptions'],
        'onLoad' => json_rep_model['onLoad']
      }
    end

    presenter_hash
  end

  def update_models
    params[:interactive][:models].each do |model_hash|
      model_url = model_hash['url'].split('/').last
      model_type = @interactive.model_type
      case model_type
      when 'energy2d'
        @interactive.energy2ds <<  Energy2d.find_by_url(model_url)
      when 'md2d'
        @interactive.md2ds << Md2d.find_by_url(model_url)
      when 'sensor'
        @interactive.sensors << Sensor.find_by_url(model_url)
      when 'signal_generator'
        @interactive.signal_generators << SignalGenerator.find_by_url(model_url)
      when 'solar_system'
        @interactive.solar_systems << SolarSystem.find_by_url(model_url)
      else
        logger.debug("Cannot find a Model for model_type #{model_type}")
      end
    end
  end

  def new_interactive_params
    params[:interactive].delete('id')
    group_path = params[:interactive].delete('groupKey')
    params[:interactive][:group_key] = group_path
    title = params[:interactive][:title]
    params[:interactive][:path] = "interactives_#{group_path}_#{title}".gsub('$','_').gsub('/',"_")
    params[:interactive].permit!
  end

  def update_interactive_models
  end

end
