class MonthRecordsController < ApplicationController
  def index
  end

  def new
    @month_record = MonthRecord.new
  end
  
  def create
    @month_record = MonthRecord.new (month_record_params)
    month_record.save
    redirect_to day_record_path(@month_record)
  end

  def show
  end

  def edit
  end
  
  private
  
  def month_record_params
    params.require(:month_record).permit(:brought_forward, :income, :water_fare, :gas_fare, :elecltrical_fare, :telephone_fare, :deposit, :insurance, :credit_card, :month_other)
  end
end
