class FinancialPlannersController < ApplicationController
  def new
    @financial_planner = FinancialPlanner.new
    render layout: "clients"
  end
  
  def create
    @financial_planner = FinancialPlanner.new(financial_planner_params)
    if @financial_planner.save
      flash[:success] = "登録に成功しました"
      log_in_as_financial_planner(@financial_planner)
      redirect_to @financial_planner
    else
      flash[:error] = "登録できませんでした"
      redirect_to new_financial_planner_path
    end
  end

  def show
    @financial_planner = FinancialPlanner.find(params[:id])
    # FPが持っている予約枠を取得
    @consultation_appointment_slots = @financial_planner.consultation_appointment_slots
    render layout: "clients"
  end

  private
    def financial_planner_params
      params.require(:financial_planner).permit(:name)
    end
end
