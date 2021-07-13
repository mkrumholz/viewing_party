require 'rails_helper'
RSpec.describe 'Dashboard parties' do
  it "Displays parties the user is hosting and has link to movie show page" do
    @user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    @friendship1 = Friendship.create(user_id: @user.id, friend_id: @user2.id)
    @friendship2 = Friendship.create(user_id: @user.id, friend_id: @user3.id)
    @friendship3 = Friendship.create(user_id: @user.id, friend_id: @user4.id)

    @party = @user.parties.create(movie_title: "Toy Story", duration: "81", date: "2021-07-14", start_time: "2021-07-12 01:00:00 -0600")
    @party.invitations.create(user_id: @user2.id)
    @party.invitations.create(user_id: @user3.id)
    visit dashboard_path

    within '.hosting' do
      expect(page).to have_content("Parties that I'm Hosting!")
      expect(page).to have_content(@party.movie_title)
      expect(page).to have_link("#{@party.movie_title}")
      expect(page).to have_content(@party.date)
      expect(page).to have_content(@party.start_time)
      expect(page).to have_content(@user2.username)
      expect(page).to have_content(@user3.username)
      expect(page).not_to have_content(@user4.username)

      click_on "#{@party.movie_title}"
    end
    expect(current_path).to eq("/movies/862")
  end

  it "Displays parties the user is invited to and has link to movie show page" do
    @user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    @friendship4 = Friendship.create(user_id: @user2.id, friend_id: @user.id)#user2 is the user with the friendships
    @friendship5 = Friendship.create(user_id: @user2.id, friend_id: @user3.id)
    @friendship3 = Friendship.create(user_id: @user2.id, friend_id: @user4.id)

    @party = @user2.parties.create!(movie_title: "Toy Story", duration: "81", date: "2021-07-14", start_time: "2021-07-12 01:00:00 -0600")
    @party.invitations.create(user_id: @user.id)#user2 creates party and invites user
    @party.invitations.create(user_id: @user3.id)
    visit dashboard_path
    within '.invited' do
      expect(page).to have_content("Parties that I'm Invited To!")
      expect(page).to have_content(@party.movie_title)
      expect(page).to have_link("#{@party.movie_title}")
      expect(page).to have_content(@party.date)
      expect(page).to have_content(@party.start_time)
      expect(page).to have_content(@user.username)#user1 is invited
      expect(page).to have_content(@user3.username)
      expect(page).not_to have_content(@user4.username)

      click_on "#{@party.movie_title}"
    end
    expect(current_path).to eq("/movies/862")
  end
end
