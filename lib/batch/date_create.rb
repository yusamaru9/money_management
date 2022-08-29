class Batch::DateCreate
  def self.date_create
    User.all.each do |user|
      
      day_records = user.day_records.where(year_month_date: Date.yesterday)
      if day_records.blank?
        user.day_records.create(year_month_date: Date.yesterday)
      else
        user.month_records.create(year_month: Date.yesterday)
      end
      
    end
  end
end