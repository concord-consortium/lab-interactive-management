class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def show
    render :json => presenter
  end

  def create
    if @model_instance.save
      render :json => @model_instance, :status => :created, :location => @model_instance
    else
      render :json => @model_instance.errors, :status => :unprocessable_entity
    end
  end

  def update
    if @model_instance_model.update_attributes(params[:model])
      render({
               :json     => presenter(@m2d_model).runtime_properties,
               :status   => :created,
               :location => models_md2d_path(@model_instance_model)
             })
    else
      render({
               :json => @interactive.errors,
               :status => :unprocessable_entity
             })

    end
  end

  private

  def set_model
    case params[:model_type]
    when 'energy2d'
      @model_instance = Energy2d.find_by_url(params[:id])
    when 'md2d'
      @model_instance = Md2d.find_by_url(params[:id])
    when 'sensor'
      @model_instance = Sensor.find_by_url(params[:id])
    when 'signal_generator'
      @model_instance = SignalGenerator.find_by_url(params[:id])
    when 'solar_system'
      @model_instance = SolarSystem.find_by_url(params[:id])
    else
      logger.debug("Cannot find a Model for model_type #{params[:model_type]}")
    end
  end

  def presenter
    presenter_hash = { 'id' => @model_instance.url, 'type' => @model_instance.json_rep['type'], 'from_import' => @model_instance.from_import }
    presenter_hash.merge!(@model_instance.attributes.delete('json_rep'))
  end

end
