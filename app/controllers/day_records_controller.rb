class DayRecordsController < ApplicationController
  
  def index
    @day_records = DayRecord.all
  end

  def new
    @day_record = DayRecord.new
  end
  
  def create
    @day_record = DayRecord.new(day_record_params)
    @day_record.user_id = current_user.id
    @day_record.save
    redirect_to day_record_path(@day_record)
  end

  def show
    @day_record = DayRecord.find(params[:id])
  end

  def edit
    @day_record = DayRecord.find(params[:id])
  end
  
  def update
    day_record = DayRecord.find(params[:id])
    day_record.update(day_record_params)
    redirect_to day_record_path(day_record.id)
  end
  
  private
  
  def day_record_params
    params.require(:day_record).permit(:year_month_date, :food_cost, :commodity, :clothing, :educate, :medical_beauty, :transport, :socializing, :amusement, :day_other, :memo)
  end
  
end
