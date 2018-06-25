class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "sent_email_success"
      redirect_to root_url
    else
      flash.now[:danger] = t "sent_error"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("email_blank"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t "reset_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
    redirect_to root_url if @user.nil?
  end

  def valid_user
    unless (@user && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "check_expiration"
      redirect_to new_password_reset_url
    end
  end
end
