class BookmarksController < ApplicationController
  
  def create
    @day_record = DayRecord.find(params[:day_record_id])
    bookmark = @day_record.bookmarks.new(user_id: current_user.id)
    bookmark.save
    redirect_to day_record_path(@day_record)
  end
  
  def destroy
    @day_record = DayRecord.find(params[:day_record_id])
    bookmark = @day_record.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
    redirect_to day_record_path(@day_record)
  end
end
