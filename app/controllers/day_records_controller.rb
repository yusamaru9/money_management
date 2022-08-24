class DayRecordsController < ApplicationController
  
  before_action :ensure_correct_day_record, only: [:edit, :show, :update]
  
  def index
    @day_records = current_user.day_records.page(params[:page]).per(7) #ログインしている自分の記録全てが表示
  end

  def new
    @day_record = DayRecord.new
    
    #user/showで記録してない日付を押すとnewページのyear_month_dateのフィールドにその日が入力される
    @day_record.year_month_date = params[:day] #user/showで使用
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
      flash[:check] = "今日は、既に記録しています。"
      redirect_to new_day_record_path
    else # falseなら
      @day_record.save
      redirect_to day_record_path(@day_record), notice: "記録が保存されました。"
    end
  end

  def show
    @day_record = DayRecord.find(params[:id])
    @day_comment = DayComment.new #コメントの空の箱
  end

  def edit
    @day_record = DayRecord.find(params[:id])
  end
  
  def update
    day_record = DayRecord.find(params[:id])
    day_record.update(day_record_params)
    redirect_to day_record_path(day_record.id)
  end
  
  def genres
    @model = params[:col]
    if @model == "food_cost"
      @food_name = params[:food_id]
      @day_genres = DayRecord.search_for(@model, @food_name)
    end
  end
  
  private
  
  def day_record_params
    params.require(:day_record).permit(:year_month_date, :food_cost, :commodity, :clothing, :educate, :medical_beauty, :transport, :socializing, :amusement, :day_other, :memo)
  end
  
  def ensure_correct_day_record
    @day_record = DayRecord.find(params[:id])
    @user = @day_record.user
    unless @user == current_user
      redirect_to day_records_path
    end
  end
  
end
