class DayRecordsController < ApplicationController
  
  before_action :ensure_correct_day_record, only: [:edit, :show, :update]
  
  def index #ログインしている自分の記録全てが表示、投稿順ではなく日付が新しい順に変更
    @day_records = current_user.day_records.page(params[:page]).per(7).order(year_month_date: :desc)
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
      if @day_record.save
        flash[:save] = "記録が保存されました。"
        redirect_to day_record_path(@day_record)
      else #バリデーション
        render :new
      end
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
    if day_record.update(day_record_params)
      flash[:update] = "変更が成功しました。"
      redirect_to day_record_path(day_record.id)
    else
      render :edit
    end
  end
  
  def day_genres
    @params = params[:item]
    #各項目（カラム）が0円で保存しているかどうか
    if @params == "food_cost" #食費
      @day_records = current_user.day_records.where.not(food_cost: 0).page(params[:page]).per(14)
      
    elsif @params == "commodity" #日用品
      @day_records = current_user.day_records.where.not(commodity: 0).page(params[:page]).per(14)
      
    elsif @params == "clothing" #被服
      @day_records = current_user.day_records.where.not(clothing: 0).page(params[:page]).per(14)
      
    elsif @params == "educate" #教育・教養
      @day_records = current_user.day_records.where.not(educate: 0).page(params[:page]).per(14)
      
    elsif @params == "medical_beauty" #医療・美容
      @day_records = current_user.day_records.where.not(medical_beauty: 0).page(params[:page]).per(14)
      
    elsif @params == "transport" #交通
      @day_records = current_user.day_records.where.not(transport: 0).page(params[:page]).per(14)
      
    elsif @params == "socializing" #交際
      @day_records = current_user.day_records.where.not(socializing: 0).page(params[:page]).per(14)
      
    elsif @params == "amusement" #娯楽
      @day_records = current_user.day_records.where.not(amusement: 0).page(params[:page]).per(14)
      
    elsif @params == "day_other" #日その他
      @day_records = current_user.day_records.where.not(day_other: 0).page(params[:page]).per(14)
    end
    
    #カレントユーザーのday_record全てにしないと他のユーザーのデータが反映されてしまうので
    @user_day_records = current_user.day_records.all
  end
  
  private
  
  def day_record_params
    params.require(:day_record).permit(:year_month_date, :food_cost, :commodity, :clothing, :educate, :medical_beauty, :transport, :socializing, :amusement, :day_other, :memo)
  end
  
  def ensure_correct_day_record
    @day_record = DayRecord.find(params[:id])
    @user = @day_record.user
    unless @user == current_user
      flash[:fraud] = "不正なアクセスです。"
      redirect_to day_records_path
    end
  end
  
end
