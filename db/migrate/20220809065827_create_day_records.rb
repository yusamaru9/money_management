class CreateDayRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :day_records do |t|
      
      t.integer :user_id, null: false
      
      t.date :year_month_date, null: false
      
      t.integer :food_cost, default: 0
      t.integer :commodity, default: 0
      t.integer :clothing, default: 0
      t.integer :educate, default: 0
      t.integer :medical_beauty, default: 0
      t.integer :transport, default: 0
      t.integer :socializing, default: 0
      t.integer :amusement, default: 0
      t.integer :day_other, default: 0
      
      t.text :memo

      t.timestamps
    end
  end
end
