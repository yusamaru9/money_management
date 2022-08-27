class Batch::Test
  def self.hello
    puts "スタート"
    DayRecord.first.inspect
    puts "完了"
  end
end