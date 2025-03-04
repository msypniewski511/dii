class BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_brand, only: %i[ show edit update destroy ]

  # GET /brands or /brands.json
  def index
    @brands = current_user.brands
  end

  # GET /brands/1 or /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    @brand = current_user.brands.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands or /brands.json
  def create
    @brand = current_user.brands.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    @brand.destroy!

    respond_to do |format|
      format.html { redirect_to brands_path, status: :see_other, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = current_user.brands.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The brand you are looking for could not be found."
      redirect_to brands_path
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:business_name, :website_domain, :strapline, :colours_fonts, :consistency, :workwear, :values, :mision_statement)
    end
end
