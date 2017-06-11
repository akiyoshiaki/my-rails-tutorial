module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    # コレはRailsが事前定義済みのsessionメソッドを利用してます
    # ActionController::Baseで定義済み
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # メソッド呼び出しです
    !current_user.nil?
  end
end
