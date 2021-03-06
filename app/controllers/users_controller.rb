class UsersController < ApplicationController

  load_and_authorize_resource

  USER_PROFILE_CREATED_MESSAGE = "Your profile was successfully created"
  USER_PROFILE_UPDATED_MESSAGE = "Your profile was successfully updated"
  NONEXISTENT_LOGIN_EMAIL_MESSAGE = "Sorry, we cannot find such login or email in out database"
  PASSWORD_RECOVERY_EMAIL_SENT_MESSAGE = "Please, check your email to recover your password"

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: USER_PROFILE_CREATED_MESSAGE }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: USER_PROFILE_UPDATED_MESSAGE }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def password_recovery
  end

  def perform_password_recovery
    user = User.find_by_email_or_login(params[:user][:login])
    respond_to do |format|
      if user
        user.recover_password

        format.html { redirect_to signin_path,
                      :notice => PASSWORD_RECOVERY_EMAIL_SENT_MESSAGE }
      else

        format.html { redirect_to password_recovery_path,
                      :notice => NONEXISTENT_LOGIN_EMAIL_MESSAGE }
      end
    end
  end
end
