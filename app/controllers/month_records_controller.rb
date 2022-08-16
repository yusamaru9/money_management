class MonthRecordsController < ApplicationController
  
  before_action :ensure_correct_month_record, only: [:edit, :show, :update]
  
  def index
    @month_records = current_user.month_records.all #ログインしている自分の記録だけが全て表示、アソシエーションでuserとmonth_recordは1対多の関係
  end

  def new
    @month_record = MonthRecord.new
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
      flash[:check] = "記録は、月に一度までです。"
      redirect_to new_month_record_path
    else
      @month_record.save
      redirect_to month_record_path(@month_record)
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
  
  def bookmarks #bookmarkの中のuserIDカラムがcurrent_userIDを探している
    @bookmarks = Bookmark.where(user_id: current_user.id) #@bookmarks = current_user.bookmarks.allと同じ意味
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
