class ChangeDateToStartsAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :parties, :date, :starts_at
  end
end
