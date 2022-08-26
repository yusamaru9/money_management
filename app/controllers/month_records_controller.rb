class MonthRecordsController < ApplicationController
  
  before_action :ensure_correct_month_record, only: [:edit, :show, :update]
  
  #ログインしている自分の記録だけが全て表示、アソシエーションでuserとmonth_recordは1対多の関係
  def index
    @month_records = current_user.month_records.page(params[:page]).per(13).order(year_month: :desc)
  end

  def new
    @month_record = MonthRecord.new
    
    @month_record.year_month = params[:month]
  end
  
  def create
    @month_record = MonthRecord.new(month_record_params)
    @month_record.user_id = current_user.id

    @month_records = current_user.month_records.all
    check = false
    @month_records.each do |month_record|
      if month_record.year_month == @month_record.year_month
        check = true
      end
    end
    
    if check
      flash[:check] = "今月は、既に記録しています。"
      redirect_to new_month_record_path
    else
      if @month_record.save
        redirect_to month_record_path(@month_record)
      else #バリデーション
        render :new
      end
    end
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
  
  #@bookmarks = current_user.bookmarks.allと同じ意味
  #bookmarkの中のuserIDカラムがcurrent_userIDを探している
  def bookmarks
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(7).order(year_month_date: :desc)
  end
  
  private
  
  def month_record_params
    params.require(:month_record).permit(:year_month, :brought_forward, :income, :water_fare, :gas_fare, :electrical_fare, :telephone_fare, :deposit, :insurance, :credit_card, :month_other)
  end
  
  def ensure_correct_month_record
    @month_record = MonthRecord.find(params[:id])
    @user = @month_record.user
    unless @user == current_user
      redirect_to month_records_path
    end
  end
  
end
