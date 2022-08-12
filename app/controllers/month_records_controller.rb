class MonthRecordsController < ApplicationController
  
  def index
    @month_records = MonthRecord.all
  end

  def new
    @month_record = MonthRecord.new
  end
  
  def create
    @month_record = MonthRecord.new(month_record_params)
    @month_record.user_id = current_user.id
    @month_record.save
    redirect_to month_record_path(@month_record) 
  end

  def show
    @month_record = MonthRecord.find(params[:id])
  end

  def edit
    @month_record = MonthRecord.find(params[:id])
  end
  
  def update
    month_record = MonthRecord.find(params[:id])
    month_record.update(month_record_params)
    redirect_to month_record_path(month_record.id)
  end
  
  private
  
  def month_record_params
    params.require(:month_record).permit(:year_month, :brought_forward, :income, :water_fare, :gas_fare, :electrical_fare, :telephone_fare, :deposit, :insurance, :credit_card, :month_other)
  end
  
end
