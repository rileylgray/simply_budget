class IncomesController < ApplicationController
  before_action :set_income, only: %i[ show edit update destroy ]

  # GET /incomes or /incomes.json

  def index
    @incomes = current_user.incomes.includes(:income_categories)
    if params[:income_category_id].present?
      @incomes = @incomes.joins(:income_categories).where(income_categories: { id: params[:income_category_id] })
    end
    @incomes = @incomes.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /incomes/1 or /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = Income.new
  end

  # GET /incomes/1/edit
  def edit
  end

  # POST /incomes or /incomes.json
  def create
    @income = current_user.incomes.new(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: "Income was successfully created." }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1 or /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to @income, notice: "Income was successfully updated." }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1 or /incomes/1.json
  def destroy
    @income.destroy!

    respond_to do |format|
      format.html { redirect_to incomes_path, status: :see_other, notice: "Income was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def income_params
      params.require(:income).permit(
        :user_id,
        :source,
        :amount,
        :received_on,
        :notes,
        :frequency,
        income_category_ids: []
      )
    end
end
