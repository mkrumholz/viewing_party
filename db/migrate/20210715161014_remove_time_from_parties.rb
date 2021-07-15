class RemoveTimeFromParties < ActiveRecord::Migration[5.2]
  def up
    remove_column :parties, :start_time
  end
  def down
    add_column :parties, :start_time, :timestamp
  end
end
