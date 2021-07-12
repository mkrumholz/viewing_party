class PartiesController < ApplicationController
  def new
    @title = params[:title]
    @duration = params[:duration]
    @viewing_party = Party.new
    require "pry"; binding.pry
  end

  def create
    new_party = Party.new(party_params)
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
    params.permit(:id, :movie_title, :duration, :date, :start_time)
  end
end
