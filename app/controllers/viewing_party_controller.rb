class ViewingPartyController < ApplicationController
  def new
    @movie = params[:movie]
  end

  def create
    new_viewing_party = ViewingParty.new(party_params)
    if new_viewing_party.save
      flash[:success] = "New Viewing Party Created"
      redirect_to dashboard_path
    else
      flash[:alert] = "Error: #{error_message(viewing_party.errors)}"
      render :new
    end
  end

  private
  def party_params
    params.permit(:id, :movie_title, :duration, :date, :start_time)
  end
end
