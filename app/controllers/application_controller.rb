class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top] #ログイン認証が成功していないと、トップページ以外の画面（ログインと新規登録は除く）は表示できない

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
