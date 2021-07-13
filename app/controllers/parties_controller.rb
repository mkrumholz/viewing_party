class PartiesController < ApplicationController
  def new
    @title = params[:title]
    @duration = params[:duration]
    @party = Party.new
  end

  def create
    new_party = current_user.parties.new(party_params)
    if params[:party][:duration] >= params[:runtime] && new_party.save
       if params[:party][:invitations].any? {|invitation| invitation != ""}
        params[:party][:invitations].each do |invitation|
          new_party.invitations.create(user_id: invitation) if invitation != ""
        end
       end
      flash[:success] = "New Viewing Party Created"
      redirect_to dashboard_path
    elsif params[:party][:duration] < params[:runtime]
      flash[:error] = "Error: Party duration must match or exceed movie runtime."
      redirect_to new_party_path({title: params[:party][:movie_title], duration: params[:runtime]})
    else
      flash[:error] = "Error: Party not created."
      render :new
    end
  end

  private
  def party_params
    params.require(:party).permit(:movie_title, :duration, :date, :start_time)
  end
end
