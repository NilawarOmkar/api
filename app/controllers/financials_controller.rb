class FinancialsController < ApplicationController
  before_action :set_financial, only: %i[ show edit update destroy ]

  # GET /financials or /financials.json
  def index
    @financials = Financial.all
  end

  # GET /financials/1 or /financials/1.json
  def show
  end

  # GET /financials/new
  def new
    @financial = Financial.new
  end

  # GET /financials/1/edit
  def edit
  end

  # POST /financials or /financials.json
  def create
    @financial = Financial.new(financial_params)

    respond_to do |format|
      if @financial.save
        format.html { redirect_to @financial, notice: "Financial was successfully created." }
        format.json { render :show, status: :created, location: @financial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @financial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financials/1 or /financials/1.json
  def update
    respond_to do |format|
      if @financial.update(financial_params)
        format.html { redirect_to @financial, notice: "Financial was successfully updated." }
        format.json { render :show, status: :ok, location: @financial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @financial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financials/1 or /financials/1.json
  def destroy
    @financial.destroy!

    respond_to do |format|
      format.html { redirect_to financials_path, status: :see_other, notice: "Financial was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financial
      @financial = Financial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def financial_params
      params.require(:financial).permit(:available_to_draw, :principal_balance, :project_commitment_amount, :loan_id)
    end
end
