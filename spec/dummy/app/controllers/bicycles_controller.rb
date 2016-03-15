class BicyclesController < ApplicationController
  before_action :set_bicycle, only: [:show, :edit, :update, :destroy]

  # GET /bicycles
  def index
    @bicycles = Bicycle.all
  end

  # GET /bicycles/1
  def show
  end

  # GET /bicycles/new
  def new
    @bicycle = Bicycle.new
  end

  # GET /bicycles/1/edit
  def edit
  end

  # POST /bicycles
  def create
    @bicycle = Bicycle.new(bicycle_params)

    if @bicycle.save
      redirect_to @bicycle, notice: 'Bicycle was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bicycles/1
  def update
    if @bicycle.update(bicycle_params)
      redirect_to @bicycle, notice: 'Bicycle was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bicycles/1
  def destroy
    @bicycle.destroy
    redirect_to bicycles_url, notice: 'Bicycle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bicycle
      @bicycle = Bicycle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bicycle_params
      params.require(:bicycle).permit(:name, :price, :qty)
    end
end
