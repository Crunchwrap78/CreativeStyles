class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show,  :destroy]
  before_action :correct_user, only: [:show, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end


  def show
  end

  def new
    @user = User.new
  end

  def edit
  end


  def create
    @user = User.new(user_params)

      if @user.save
        sign_in @user
         redirect_to user_path(current_user), notice: 'Welcome!'
      else
        render :new
      end

  end


  def update

      if @user.update(user_params)
       redirect_to @user, notice: 'User was successfully updated.'
      else
         render :edit
      end

  end


  def destroy
    @user.destroy

    redirect_to users_url, notice: 'User deleted'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def correct_user
      user = User.find_by(id: params[:id])
      redirect_to root_url unless current_user?(user)
    end

end
