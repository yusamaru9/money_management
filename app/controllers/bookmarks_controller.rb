class BookmarksController < ApplicationController
  
  # before_action :ensure_correct_bookmark
  
  def create
    @day_record = DayRecord.find(params[:day_record_id])
    bookmark = @day_record.bookmarks.new(user_id: current_user.id)
    bookmark.save
    redirect_to request.referer
  end
  
  def destroy
    @day_record = DayRecord.find(params[:day_record_id])
    bookmark = @day_record.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy
    redirect_to request.referer
  end
  
  private
  
  # def ensure_correct_bookmark
    
  # end
end
