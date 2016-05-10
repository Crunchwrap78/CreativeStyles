class SessionsController < ApplicationController
  before_action :find_user

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_path(current_user)
    else
      "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def find_user
    @user = current_user
  end

end
