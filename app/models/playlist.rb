class Playlist < ActiveRecord::Base
belongs_to :user
require 'soundcloud'

  def self.soundcloud_api_search(user_playlist_input)
    if user_playlist_input != nil
      random_playlist_id = rand(0..5)
      client = Soundcloud.new(:client_id => '03831e5faf6ff51fce1c2737ebfb02a6')
      playlist = client.get('/playlists', :q => user_playlist_input, :limit => 5)
      { soundcloud_id:  playlist[random_playlist_id ]["id"],
        name:           playlist[random_playlist_id ]["title"]
      }
    end
  end


end
