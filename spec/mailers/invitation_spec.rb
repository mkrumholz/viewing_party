require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe 'invite' do
    let(:user) { User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password') }
    let(:user2) { User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password') }
    let(:party) { user.parties.create(movie_title: "Toy Story", duration: "81", date: "2021-07-14", external_movie_id: 862) }

    let(:mail) { InvitationMailer.invite(user, user2, party).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq "#{user.username} has invited you to a viewing party!"
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(['user2@test.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@rocky-retreat-38535.herokuapp.com/'])
    end

    it 'assigns @host' do
      expect(mail.body.encoded).to match(user.username)
    end

    it 'assigns @friend' do
      expect(mail.body.encoded).to match(user2.username)
    end

    it 'assigns @party and shows details' do
      expect(mail.body.encoded).to match(party.movie_title)
      expect(mail.body.encoded).to match('Wednesday, July 14, 2021')
      expect(mail.body.encoded).to match('07:00pm')
      expect(mail.body.encoded).to match('1 hr 21 min')
    end
  end
end
