class MonthRecord < ApplicationRecord
  
  belongs_to :user
  
  attribute :brought_forward, :integer, default: 0
  attribute :income, :integer, default: 0
  attribute :water_fare, :integer, default: 0
  attribute :gas_fare, :integer, default: 0
  attribute :electrical_fare, :integer, default: 0
  attribute :telephone_fare, :integer, default: 0
  attribute :deposit, :integer, default: 0
  attribute :insurance, :integer, default: 0
  attribute :credit_card, :integer, default: 0
  attribute :month_other, :integer, default: 0
  
  validates :brought_forward, presence: true
  validates :income, presence: true
  validates :water_fare, presence: true
  validates :gas_fare, presence: true
  validates :electrical_fare, presence: true
  validates :telephone_fare, presence: true
  validates :deposit, presence: true
  validates :insurance, presence: true
  validates :credit_card, presence: true
  validates :month_other, presence: true
  
  def income_total #収入合計
    (brought_forward + income)
  end
  
  def expenditure_total #支出合計
    (water_fare + gas_fare + electrical_fare + telephone_fare + deposit + insurance + credit_card + month_other)
  end
  
  def freedom_money #使えるお金
    (income_total - expenditure_total)
  end
  
end
