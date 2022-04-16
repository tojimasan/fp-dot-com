class SessionsController < ApplicationController
  layout "login_logout"

  def new
  end

  def create
    input_name = params[:session][:name]
    client = Client.find_by(name: input_name)

    if client
      # クライアントログイン後にクライアント情報のページにリダイレクトする
      log_in_as_client(client)
      flash[:success] = "ログインしました"
      redirect_to client
    elsif financial_planner = FinancialPlanner.find_by(name: input_name)
      log_in_as_financial_planner(financial_planner)
      flash[:success] = "ログインしました"
      redirect_to financial_planner
    else
      flash.now[:error] = "未登録のユーザーです"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
end
