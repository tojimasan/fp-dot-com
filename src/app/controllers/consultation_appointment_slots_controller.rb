class ConsultationAppointmentSlotsController < ApplicationController
  before_action :logged_in_user
  before_action :logged_in_fp, only: [:new, :create]
  before_action :logged_in_client, only: [:index, :edit, :update]
  SLOT_DURATION = 1800

  def index
    @consultation_appointment_slots = ConsultationAppointmentSlot.where(status: 1)
    render layout: "consultation_appointment_slots"
  end

  def new
    @consultation_appointment_slot = ConsultationAppointmentSlot.new
    render layout: "consultation_appointment_slots"
  end

  def create
    @consultation_appointment_slot = ConsultationAppointmentSlot.new(consultation_appointment_slots_params)
    # end_atは固定でstart_atの30分(1800秒)後とする
    @consultation_appointment_slot.end_at = @consultation_appointment_slot.start_at + SLOT_DURATION

    # 同じ時間にFPが予約枠を作成済みであったら作成しない
    if ConsultationAppointmentSlot.exists?(financial_planner_id: current_user.id, start_at: params[:consultation_appointment_slot][:start_at])
      flash[:error] = '同じ時間に予約枠を作成済みです'
      redirect_to new_consultation_appointment_slot_path
    # before_actionでFPユーザーであることは確認しているため、current_userはFPユーザーである
    elsif current_user.consultation_appointment_slots << @consultation_appointment_slot
      flash[:message] = '予約枠を作成しました'
      redirect_to financial_planner_path(current_user.id)
    else
      flash.now[:error] = '予約枠を作成できませんでした'
      render new_consultation_appointment_slot_path
    end
  end

  def edit
    @consultation_appointment_slot = ConsultationAppointmentSlot.find(params[:id])
    @client_id = current_user.id
  end

  def update
    @consultation_appointment_slot = ConsultationAppointmentSlot.find(params[:id])
      if @consultation_appointment_slot.status == 2
        flash[:error] = "すでに予約されています"
        render 'edit'
      elsif @consultation_appointment_slot.update(consultation_appointment_slots_params)
        flash[:success] = "予約しました"
        redirect_to current_user
      else
        flash.now[:error] = "予約できませんでした"
        render 'edit'
      end
  end
  

  private
    def consultation_appointment_slots_params
      params.require(:consultation_appointment_slot).permit(:start_at, :status, :client_id)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_path
      end
    end

    def logged_in_fp
      if !logged_in? || FinancialPlanner.find_by(id: current_user.id, name: current_user.name).nil?
        flash[:danger] = "FPユーザーのみ予約枠の作成可能です"
        redirect_to login_path
      end
    end

    def logged_in_client
      if !logged_in? || Client.find_by(id: current_user.id, name: current_user.name).nil?
        flash[:danger] = "クライアントユーザーのみ予約枠の更新可能です"
        redirect_to login_path
      end
    end
end
