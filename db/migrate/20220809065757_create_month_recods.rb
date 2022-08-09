class CreateMonthRecods < ActiveRecord::Migration[6.1]
  def change
    create_table :month_recods do |t|
      
      t.date :year_month, null: false #毎月1日で固定する
      
      t.integer :brought_forward, default: 0
      t.integer :income, default: 0
      t.integer :water_fare, default: 0
      t.integer :gas_fare, default: 0
      t.integer :electrical_fare, default: 0
      t.integer :telephone_fare, default: 0
      t.integer :deposit, default: 0
      t.integer :insurance, default: 0
      t.integer :credit_card, default: 0
      t.integer :month_other, default: 0

      t.timestamps
    end
  end
end
