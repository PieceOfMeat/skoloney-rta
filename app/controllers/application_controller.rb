class ApplicationController < ActionController::Base
  include SessionsHelper

  NOT_AUTHORIZED_MESSAGE = "You are not authorized to perform this action"
  NOT_AUTHENTICATED_MESSAGE = "You need to authenticate to perform this action"
  
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if signed_in?
      redirect_to root_url, :notice => NOT_AUTHORIZED_MESSAGE
    else
      redirect_to signin_url, :notice => NOT_AUTHENTICATED_MESSAGE
    end
  end
end
