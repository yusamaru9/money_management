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
  
end
