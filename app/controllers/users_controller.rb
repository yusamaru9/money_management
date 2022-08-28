class UsersController < ApplicationController
  
  #他のユーザーページのURLを手打ちで入力しても遷移できないようにする
  before_action :ensure_correct_user
  before_action :set_beginning_of_week
  
  def show
    #ログインしているユーザー本人が記録した情報の全て（他のユーザーの記録した情報を表示させない）
    @day_records = current_user.day_records.all
  end
  
  
  private
  
  #カレンダーを日曜日始まりに変更
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
