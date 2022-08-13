class UsersController < ApplicationController
  def show
    @day_records = DayRecord.all
  end
end
