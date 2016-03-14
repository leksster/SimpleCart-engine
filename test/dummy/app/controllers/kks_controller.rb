class KksController < ApplicationController
  before_action :set_kk, only: [:show, :edit, :update, :destroy]

  # GET /kks
  def index
    @kks = Kk.all
  end

  # GET /kks/1
  def show
  end

  # GET /kks/new
  def new
    @kk = Kk.new
  end

  # GET /kks/1/edit
  def edit
  end

  # POST /kks
  def create
    @kk = Kk.new(kk_params)

    if @kk.save
      redirect_to @kk, notice: 'Kk was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kks/1
  def update
    if @kk.update(kk_params)
      redirect_to @kk, notice: 'Kk was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kks/1
  def destroy
    @kk.destroy
    redirect_to kks_url, notice: 'Kk was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kk
      @kk = Kk.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kk_params
      params.require(:kk).permit(:name, :price, :qty)
    end
end
