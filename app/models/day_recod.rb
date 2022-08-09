class DayRecod < ApplicationRecord
  
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
end
