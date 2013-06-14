class SessionsController < ApplicationController

  INVALID_LOGIN_PASSWORD_MESSAGE = 'Invalid email/password combination'

  def new
  end

  def create
    user = User.find_by_email_or_login(params[:session][:login])

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      respond_to do |format|
        format.html { redirect_to signin_path, :notice => INVALID_LOGIN_PASSWORD_MESSAGE }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
