class VideosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @videos = Video.order('created_at DESC')
  end

  def new
    @user = User.find(params[:user_id])
    @video = Video.new
  end

  def create
    @user = User.find(params[:user_id])
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = 'Video added!'
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:link)
  end
end
