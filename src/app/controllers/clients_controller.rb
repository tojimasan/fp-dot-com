class ClientsController < ApplicationController
    def new
        @client = Client.new
        render layout: "clients"
    end

    def create
        @client = Client.new(client_params)
        if @client.save
          flash[:success] = "登録に成功しました"
          log_in_as_client(@client)
          redirect_to client_path(@client.id)
        else
          flash.now[:error] = "登録に失敗しました"
          render new_client_path
        end
    end

    def show
        @client = Client.find(params[:id])
        @consultation_appointment_slots = ConsultationAppointmentSlot.where(client_id: params[:id])
        render layout: "clients"
    end

    private
        def client_params
          params.require(:client).permit(:name)
        end
end
