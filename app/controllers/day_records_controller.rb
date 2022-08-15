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
    
    @day_records = current_user.day_records.all #自分の記録の全て
    @check = false
    @day_records.each do |day_record| #自分の記録の全てを一つずつ取り出して同じ日付かどうか処理する
      if day_record.year_month_date == @day_record.year_month_date
        @check = true #同じ日付があれはtrueになる
      end
    end
    
    if @check #trueなら
      flash[:check] = "投稿は、一日に一度までです。"
      redirect_to new_day_record_path
    else # falseなら
      @day_record.save
      redirect_to day_record_path(@day_record)
    end
  end

  def show
    @day_record = DayRecord.find(params[:id])
    @day_comment = DayComment.new #コメントの空の
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
