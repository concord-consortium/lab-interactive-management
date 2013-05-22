module Models
  class Md2dsController < ApplicationController
    before_action :set_md2d, only: [:show, :edit, :update, :destroy]
    # def index
    #   @md2ds = Models::Md2d.all
    #   render :json => @md2ds.collect { |m|
    #     presenter(m).json_listing
    #   }
    # end

    def show
      render :json => presenter
    end

    def create
      @md2d = Models::Md2d.new(params[:md2d])
      if @md2d.save
        render :json => @md2d, :status => :created, :location => @md2d
      else
        render :json => @md2d.errors, :status => :unprocessable_entity
      end
    end

    def update
      @md2d_model = Models::Md2d.find(params['id'])

      if @md2d_model.update_attributes(params[:md2d])
        render({
                 :json     => presenter(@m2d_model).runtime_properties,
                 :status   => :created,
                 :location => models_md2d_path(@md2d_model)
               })
      else
        render({
                 :json => @interactive.errors,
                 :status => :unprocessable_entity
               })

      end
    end

    private

    def set_md2d
      @md2d = Md2d.find_by_url(params[:id])
    end

    def presenter
      presenter_hash = { 'id' => @md2d.url, 'type' => 'md2d' }
      presenter_hash.merge!(@md2d.attributes.delete('json_rep'))
    end

  end
end
