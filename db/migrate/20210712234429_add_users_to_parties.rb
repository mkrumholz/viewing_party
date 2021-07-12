class AddUsersToParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :parties, :user, foreign_key: true
  end
end
