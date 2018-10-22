require 'will_paginate/array'

class SourcesController < ApplicationController
  before_action :require_login, except: [ :list, :feed ]
  rescue_from ActionController::UnknownFormat, with: :raise_not_found
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 12).order(title: :asc)
    @sources = Source.all
  end

  # GET /sources/new
  def new
    @source = Source.new
  end

  # GET /sources/1/edit
  def edit
  end

  # POST /sources
  # POST /sources.json
  def create
    # render plain: params.inspect
    @source = Source.new(source_params)

    respond_to do |format|
      if @source.save
        format.html { redirect_to sources_path, notice: 'Source was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to sources_path, notice: 'Source was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: 'Source was successfully destroyed.' }
    end
  end

  def feed
    @recipes = Recipe.where(public: true).order(updated_at: :desc).limit(10)
    render content_type: 'text/plain'
  end

  def list

#    @recipes = if @published then Recipe.where(public: true).order(title: :asc)
#      else  Recipe.order(title: :asc)
#    end

    @recipes = if @published then Recipe.search(params[:query]).paginate(page: params[:page], per_page: 6).where(public: true).order(title: :asc)
      else  Recipe.search(params[:query]).paginate(page: params[:page], per_page: 6).order(title: :asc)
    end

    @last = Recipe.where(public: true).order(updated_at: :desc).limit(1).last
    @cloud = Recipe.where(public: true).shuffle(random: Random.new(Time.now.to_i))[0...1]

#    @recipes = if params.has_key?(:tags) and !params[:tags].empty?
#      @recipes.order(title: :asc).reject do |recipe|
#        not recipe.all_tags.split(',').any? { |v|
#          params[:tags].split(',').include? v.strip
#        }
#      end
#    else
#      @recipes
#    end
     
#    @recipes = @recipes.paginate(page: params[:page], per_page: 3)

    respond_to do |format|
      format.html { render }
      format.text { render }
      format.markdown { render content_type: 'text/plain' }
      format.plain { render content_type: 'text/plain' }
    end
  end

  def raise_not_found
    render text: 'Not Found', status: 404
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(:title, :url, :recipe_id)
    end
end
