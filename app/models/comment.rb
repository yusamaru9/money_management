class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :day_recod
  
end
