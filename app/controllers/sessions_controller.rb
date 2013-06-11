class SessionsController < ApplicationController

  INVALID_LOGIN_PASSWORD_MESSAGE = 'Invalid email/password combination'

  def new
  end

  def create
    login = params[:session][:login].downcase
    user = User.find_by_email(login) || User.first(:conditions => ["lower(login) = ?", login])

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      render 'new', :locals => { :notice => INVALID_LOGIN_PASSWORD_MESSAGE }
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
