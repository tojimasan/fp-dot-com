class SessionsController < ApplicationController
  def new
    render layout: "login_logout"
  end

  def create
    input_name = params[:session][:name]
    client = Client.find_by(name: input_name)

    if client
      # クライアントログイン後にクライアント情報のページにリダイレクトする
      log_in_as_client(client)
      redirect_to client
    elsif financial_planner = FinancialPlanner.find_by(name: input_name)
      log_in_as_financial_planner(financial_planner)
      redirect_to financial_planner
    else
      flash[:error] = '未登録のユーザーです'
      redirect_to login_path
    end
  end
end
