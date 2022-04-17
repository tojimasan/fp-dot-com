class ConsultationAppointmentSlotsController < ApplicationController
  before_action :logged_in_user
  before_action :logged_in_fp
  SLOT_DURATION = 1800

  def new
    @consultation_appointment_slot = ConsultationAppointmentSlot.new
  end

  def create
    @consultation_appointment_slot = ConsultationAppointmentSlot.new(consultation_appointment_slots_params)
    # end_atは固定でstart_atの30分(1800秒)後とする
    @consultation_appointment_slot.end_at = @consultation_appointment_slot.start_at + SLOT_DURATION

    # before_actionでFPユーザーであることは確認しているため、current_userはFPユーザーである
    if current_user.consultation_appointment_slots << @consultation_appointment_slot
      flash[:message] = '予約枠を作成しました'
    else
      flash[:message] = '予約枠を作成できませんでした'
    end

    redirect_to consultation_appointment_slots_new_path
  end

  private
    def consultation_appointment_slots_params
      params.require(:consultation_appointment_slot).permit(:start_at)
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
end
