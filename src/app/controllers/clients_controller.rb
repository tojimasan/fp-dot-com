class ClientsController < ApplicationController
    def new
        @client = Client.new
        render layout: "clients"
    end

    def create
        @client = Client.new(client_params)
        if @client.save
          flash[:success] = "作成に成功しました"
          redirect_to client_path(@client.id)
        else
          flash[:error] = "作成できませんでした"
          redirect_to new_client_path
        end
    end

    def show
        @client = Client.find(params[:id])
        render layout: "clients"
    end

    private
        def client_params
        params.require(:client).permit(:name)
        end
end
