class Bookmark < ApplicationRecord
  
  belongs_to :user
  belongs_to :day_record
  
end
