class AddExternalMovieIdToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :external_movie_id, :integer
  end
end
