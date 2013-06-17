class SessionsController < ApplicationController

  INVALID_LOGIN_PASSWORD_MESSAGE = 'Invalid email/password combination'

  def new
    authorize! :signin, :session
  end

  def create
    authorize! :signin, :session
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
    authorize! :signout, :session
    sign_out
    redirect_to root_url
  end
end
