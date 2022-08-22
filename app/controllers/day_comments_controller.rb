class DayCommentsController < ApplicationController
  
  def create
    # 非同期通信化でjsファイルで@day_recordを使用したいから@day_recordを定義する
    # 同期通信だとローカル変数を定義すればcreateできる
    @day_record = DayRecord.find(params[:day_record_id])
    day_comment = current_user.day_comments.new(post_comment_params)
    day_comment.day_record_id = @day_record.id
    day_comment.save
  end
  
  def destroy
    DayComment.find(params[:id]).destroy
    # 非同期通信化でjsファイルで@day_recordを使用したいから@day_recordを定義する
    @day_record = DayRecord.find(params[:day_record_id])
  end
  
  private
  
  def post_comment_params
    params.require(:day_comment).permit(:comment)
  end
  
end
