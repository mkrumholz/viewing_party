class InvitationMailer < ApplicationMailer
  def invite(host, friend, party)
    @host = host.username
    @friend = friend.username
    @party = party

    mail to: friend.email, subject: "#{host.username} has invited you to a viewing party!"
  end
end
