class Admin::LunchboxesController < ApplicationController
  before_action :set_lunchbox, only: [:show, :edit, :update, :destroy]

  # GET /lunchboxes
  def index
    @lunchboxes = Lunchbox.all
  end

  # GET /lunchboxes/1
  def show
  end

  # GET /lunchboxes/new
  def new
    @lunchbox = Lunchbox.new
  end

  # GET /lunchboxes/1/edit
  def edit
  end

  # POST /lunchboxes
  def create
    @lunchbox = Lunchbox.new(lunchbox_params)

    if @lunchbox.save
      redirect_to admin_lunchboxes_path, notice: 'Lunchbox was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lunchboxes/1
  def update
    if @lunchbox.update(lunchbox_params)
      redirect_to @lunchbox, notice: 'Lunchbox was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lunchboxes/1
  def destroy
    @lunchbox.destroy
    redirect_to lunchboxes_url, notice: 'Lunchbox was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunchbox
      @lunchbox = Lunchbox.find(params[:id])
    end

    # # Only allow a trusted parameter "white list" through.
  # def lunchbox_params
  #   params.fetch(:lunchbox, {})
  # end

    def lunchbox_params
      params.require(:lunchbox).permit(:name, :price)
    end

end
