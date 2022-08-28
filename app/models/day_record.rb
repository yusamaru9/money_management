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
  
  validates :food_cost, presence: true
  validates :commodity, presence: true
  validates :clothing, presence: true
  validates :educate, presence: true
  validates :medical_beauty, presence: true
  validates :transport, presence: true
  validates :socializing, presence: true
  validates :amusement, presence: true
  validates :day_other, presence: true

  #1日の支出合計
  def day_expenditure_total
    (food_cost + commodity + clothing + educate + medical_beauty + transport + socializing + amusement + day_other)
  end
  
  #カレンダー内の日付毎に表示するため
  def start_time
    self.year_month_date
  end
  
  #引数で渡されたユーザidがbookmarksテーブル内に存在（exists?）するかどうか
  #存在していればtrue、存在していなければfalse
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
