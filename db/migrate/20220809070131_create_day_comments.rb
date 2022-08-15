class CreateDayComments < ActiveRecord::Migration[6.1]
  def change
    create_table :day_comments do |t|
      
      t.integer :user_id, null: false
      t.integer :day_record_id, null: false
      
      t.text :comment, null: false

      t.timestamps
    end
  end
end
