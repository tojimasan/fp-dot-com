module SessionsHelper
    def log_in_as_client(client)
        session[:client_id] = client.id
    end

    def log_in_as_financial_planner(financial_planner)
        session[:financial_planner_id] = financial_planner.id
    end

    def log_out
        session.delete(:client_id)
        session.delete(:financial_planner_id)
        @current_user = nil
    end

    # 現在ログイン中のユーザーを返す
    # クライアント、FPどちらかでログインしている場合にはセッションにidがあるので、
    # idを用いてfind_byを行う
    def current_user
        if session[:client_id] || session[:financial_planner_id]
            @current_user ||= Client.find_by(id: session[:client_id])
            @current_user ||= FinancialPlanner.find_by(id: session[:financial_planner_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end
end
