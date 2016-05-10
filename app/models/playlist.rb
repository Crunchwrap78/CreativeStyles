class Playlist < ActiveRecord::Base
belongs_to :user
require 'soundcloud'

  def self.soundcloud_api_search(user_playlist_input)
    if user_playlist_input != nil
      random_playlist_id = rand(0..9)
      client = Soundcloud.new(:client_id => '13ac87726f10f3cd25a2299040d3fa7c')
      playlist = client.get('/tracks', :q => user_playlist_input, :limit => 9)
      {
        soundcloud_id:  playlist[random_playlist_id ]["id"],
        name:           playlist[random_playlist_id ]["title"]
      }
    end
  end


end
