class DayRecord < ApplicationRecord
  
  belongs_to :user
  
  has_many :day_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  attribute :food_cost, :integer, default: 0
  attribute :commodity, :integer, default: 0
  attribute :clothing, :integer, default: 0
  attribute :educate, :integer, default: 0
  attribute :medical_beauty, :integer, default: 0
  attribute :transport, :integer, default: 0
  attribute :socializing, :integer, default: 0
  attribute :amusement, :integer, default: 0
  attribute :day_other, :integer, default: 0
  
  def day_expenditure_total #1日の支出合計
    (food_cost + commodity + clothing + educate + medical_beauty + transport + socializing + amusement + day_other)
  end
  
  def start_time #カレンダー内の日付毎に表示するため
    self.year_month_date
  end
  
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
