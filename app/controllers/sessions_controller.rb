class SessionsController < ApplicationController
  def new
  end

  # From "login" form button
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      # 正しくない時はやり直し
      # flash.nowのメッセージはその後のリクエスト時に消滅する
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
