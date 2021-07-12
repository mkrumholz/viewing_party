class PartiesController < ApplicationController
  def new
    @title = params[:title]
    @duration = params[:duration]
    @party = Party.new
  end

  def create
    new_party = current_user.parties.new(party_params)
    if new_party.save
      flash[:success] = "New Viewing Party Created"
      redirect_to dashboard_path
    else
      flash[:error] = "Error: Party not created"
      render :new
    end
  end

  private
  def party_params
    params.require(:party).permit(:movie_title, :duration, :date, :start_time)
  end
end
