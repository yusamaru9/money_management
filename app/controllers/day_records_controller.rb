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
    
    @day_records = current_user.day_records #自分の記録の全て
    
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
      flash[:update] = "記録が変更できました。"
      redirect_to day_record_path(day_record.id)
    else
      render :edit
    end
  end
  
  def day_genres
    #@paramsに各カラム（item）を入れる
    @params = params[:item]
    
    #フィールドで送られた値を整数型へ変更し、定義する
    @year = params["year_month_date(1i)"].to_i
    @month = params["year_month_date(2i)"].to_i
      
    #@yearにはデフォルトで0が入ってしまっているので、@yearが0以外(一度day_genresのviewを表示した後検索した時)
    if @year != 0
      beginning = Date.new(@year, @month).beginning_of_month
      last = Date.new(@year, @month).end_of_month
    #項目のリンクをクリックして初めてday_genresのviewに飛んだ時
    else
      @year = Date.today.year
      @month = Date.today.month
      #beginning_of_monthは、月初
      beginning = Date.today.beginning_of_month
      #end_of_monthは、月末
      last = Date.today.end_of_month
    end
    
    #各項目（カラム）が0円で保存しているかどうか
    #その項目の月初から月末までの0円以外のデータを1日→末日の順に並べる
    if @params == "food_cost" #食費
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(food_cost: 0).order(year_month_date: :asc)
      
    elsif @params == "commodity" #日用品
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(commodity: 0).order(year_month_date: :asc)
      
    elsif @params == "clothing" #被服
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(clothing: 0)
      
    elsif @params == "educate" #教育・教養
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(educate: 0)
      
    elsif @params == "medical_beauty" #医療・美容
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(medical_beauty: 0)
      
    elsif @params == "transport" #交通
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(transport: 0)
      
    elsif @params == "socializing" #交際
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(socializing: 0)
      
    elsif @params == "amusement" #娯楽
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(amusement: 0)
      
    elsif @params == "day_other" #日その他
      @day_records = current_user.day_records.where(year_month_date: beginning...last).where.not(day_other: 0)
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
