class PartiesController < ApplicationController
  def new
    @id = params[:external_movie_id]
    @title = params[:title]
    @duration = params[:duration]
    @party = Party.new
  end

  def create
    new_party = current_user.parties.new(party_params)
    if params[:party][:duration] < params[:runtime]
      flash[:error] = 'Error: Party duration must match or exceed movie runtime.'
      redirect_with_params
    elsif params[:party][:invitations].nil? || params[:party][:invitations].all? {|friend| friend == ""}
      flash[:error] = 'Error: Party must need friends.'
      redirect_with_params
    elsif new_party.save
      create_invitations
     flash[:success] = 'New Viewing Party Created'
     redirect_to dashboard_path
    else
      flash[:error] = 'Error: Party not created'
      redirect_with_params
    end
  end

  private
  def create_invitations
    new_party = current_user.parties.new(party_params)
    new_party.save
    params[:party][:invitations].each do |invitation|
      new_party.invitations.create(user_id: invitation) if invitation != ''
    end
  end

  def redirect_with_params
    redirect_to new_party_path({ title: params[:party][:movie_title], duration: params[:runtime], external_movie_id: params[:external_movie_id] })
  end

  def party_params
    params.require(:party).permit(:movie_title, :duration, :date, :start_time)
    .merge({ external_movie_id: params[:external_movie_id] })
  end
end
