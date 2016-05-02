class Video < ActiveRecord::Base
  searchable do
    string :title  
  end
end
