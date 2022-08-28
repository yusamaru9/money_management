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
  
  with_options presence: true do
    validates :brought_forward
    validates :income
    validates :water_fare
    validates :gas_fare
    validates :electrical_fare
    validates :telephone_fare
    validates :deposit
    validates :insurance
    validates :credit_card
    validates :month_other
  end
  
  #収入合計
  def income_total
    (brought_forward + income)
  end
  
  #決まった支出合計
  def expenditure_total
    (water_fare + gas_fare + electrical_fare + telephone_fare + deposit + insurance + credit_card + month_other)
  end
  
  #収入合計から決まった支出合計を引いた自由に使えるお金
  def freedom_money
    (income_total - expenditure_total)
  end
  
end
