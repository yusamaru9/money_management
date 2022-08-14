class UsersController < ApplicationController
  
  def show
    @day_records = DayRecord.all
  end
  
  
  before_action :set_beginning_of_week
  
  private
  
  def set_beginning_of_week #日曜日始まり
    Date.beginning_of_week = :sunday
  end
end
