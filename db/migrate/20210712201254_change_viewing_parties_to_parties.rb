class ChangeViewingPartiesToParties < ActiveRecord::Migration[5.2]
  def change
    rename_table :viewing_parties, :parties
  end
end
