class BookmarksController < ApplicationController
  
  def create
    @day_record = DayRecord.find(params[:day_record_id])
    # jsファイル読み込むためにbookmarkをインスタンス変数（@bookmark）にする（destroyも同様）
    @bookmark = @day_record.bookmarks.new(user_id: current_user.id)
    @bookmark.save
  end
  
  def destroy
    @day_record = DayRecord.find(params[:day_record_id])
    @bookmark = @day_record.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy
  end
  
end
