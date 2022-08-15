class DayCommentsController < ApplicationController
  
  def create
    day_record = DayRecord.find(params[:day_record_id])
    day_comment = current_user.day_comments.new(post_comment_params)
    day_comment.day_record_id = day_record.id
    day_comment.save
    redirect_to day_record_path(day_record)
  end
  
  private
  
  def post_comment_params
    params.require(:day_comment).permit(:comment)
  end
  
end
