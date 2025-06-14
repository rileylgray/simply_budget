class ExpenseCategoriesController < ApplicationController
  before_action :require_login
  before_action :set_expense_category, only: %i[ show edit update destroy ]

  # GET /expense_categories or /expense_categories.json
  def index
    @expense_categories = current_user.expense_categories.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /expense_categories/1 or /expense_categories/1.json
  def show
  end

  # GET /expense_categories/new
  def new
    @expense_category = ExpenseCategory.new
  end

  # GET /expense_categories/1/edit
  def edit
  end

  # POST /expense_categories or /expense_categories.json
  def create
    @expense_category = current_user.expense_categories.new(expense_category_params)

    respond_to do |format|
      if @expense_category.save
        format.html { redirect_to @expense_category, notice: "Expense category was successfully created." }
        format.json { render :show, status: :created, location: @expense_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expense_categories/1 or /expense_categories/1.json
  def update
    respond_to do |format|
      if @expense_category.update(expense_category_params)
        format.html { redirect_to @expense_category, notice: "Expense category was successfully updated." }
        format.json { render :show, status: :ok, location: @expense_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_categories/1 or /expense_categories/1.json
  def destroy
    @expense_category.destroy!

    respond_to do |format|
      format.html { redirect_to expense_categories_path, status: :see_other, notice: "Expense category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_category
      @expense_category = ExpenseCategory.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def expense_category_params
      params.require(:expense_category).permit(:name, :description, :colour)
    end
end
