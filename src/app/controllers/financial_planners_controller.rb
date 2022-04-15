class FinancialPlannersController < ApplicationController
  def new
    @financial_planner = FinancialPlanner.new
    render layout: "clients"
  end
  
  def create
    @financial_planner = FinancialPlanner.new(financial_planner_params)
    if @financial_planner.save
      flash[:success] = "登録に成功しました"
      redirect_to @financial_planner
    else
      flash[:error] = "登録できませんでした"
      redirect_to new_financial_planner
    end
  end

  def show
    @financial_planner = FinancialPlanner.find(params[:id])
    render layout: "clients"
  end

  private
    def financial_planner_params
      params.require(:financial_planner).permit(:name)
    end
end
