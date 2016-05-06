class PlaylistsController < ApplicationController
before_action :signed_in_user
before_action :find_user
before_action :find_playlist, only: [:show, :destroy]

require 'soundcloud'

  def new
    # @playlists = Playlist.all
     if params[:playlist_user_input] != nil
      @playlist = Playlist.soundcloud_api_search(params[:playlist_user_input])
      # @playlist = Playlist.new(soundcloud_id)
     end
  end

  def index
    @playlists = Playlist.where(user_id: @user.id)
  end

  def show
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    @playlist.save
    redirect_to user_playlists_path
  end

  def destroy
    @playlist.destroy
    redirect_to user_playlists_path, notice: 'Playlist deleted'
  end


  private

    def playlist_params
      params.require(:playlist).permit(:soundcloud_id, :name, :user_id)
    end

    def find_user
      @user = current_user
    end

    def find_playlist
      @playlist = Playlist.find(params[:id])
    end

end
