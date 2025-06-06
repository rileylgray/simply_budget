class IncomeCategoriesController < ApplicationController
  before_action :require_login
  before_action :set_income_category, only: %i[ show edit update destroy ]

  # GET /income_categories or /income_categories.json
  def index
    @income_categories = current_user.income_categories.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /income_categories/1 or /income_categories/1.json
  def show
  end

  # GET /income_categories/new
  def new
    @income_category = IncomeCategory.new
  end

  # GET /income_categories/1/edit
  def edit
  end

  # POST /income_categories or /income_categories.json
  def create
    @income_category = current_user.income_categories.new(income_category_params)

    respond_to do |format|
      if @income_category.save
        format.html { redirect_to @income_category, notice: "Income category was successfully created." }
        format.json { render :show, status: :created, location: @income_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @income_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /income_categories/1 or /income_categories/1.json
  def update
    respond_to do |format|
      if @income_category.update(income_category_params)
        format.html { redirect_to @income_category, notice: "Income category was successfully updated." }
        format.json { render :show, status: :ok, location: @income_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @income_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /income_categories/1 or /income_categories/1.json
  def destroy
    @income_category.destroy!

    respond_to do |format|
      format.html { redirect_to income_categories_path, status: :see_other, notice: "Income category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income_category
      @income_category = IncomeCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def income_category_params
      params.require(:income_category).permit(:name, :description, :colour)
    end
end
