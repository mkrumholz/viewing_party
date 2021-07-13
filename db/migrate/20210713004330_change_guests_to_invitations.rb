class ChangeGuestsToInvitations < ActiveRecord::Migration[5.2]
  def change
    rename_table :guests, :invitations
  end
end
