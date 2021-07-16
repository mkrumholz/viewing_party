class ChangeDatatypeForDate < ActiveRecord::Migration[5.2]
  def self.up
    change_table :parties do |t|
      t.change :date, :datetime
    end
  end
  def self.down
    change_table :parties do |t|
      t.change :date, :date
    end
  end
end
