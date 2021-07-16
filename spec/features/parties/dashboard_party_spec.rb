require 'rails_helper'
RSpec.describe 'Dashboard parties' do
  before :each do
    response_body = File.read('./spec/fixtures/toy_story.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/862?api_key=#{ENV['MOVIE_DB_KEY']}&language=en&append_to_response=credits,reviews")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body, headers: {})
  end

  it "Displays parties the user is hosting" do
    user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship1 = Friendship.create(user_id: user.id, friend_id: user2.id)
    friendship2 = Friendship.create(user_id: user.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user.id, friend_id: user4.id)
    party = user.parties.create(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)
    party.invitations.create(user_id: user2.id)
    party.invitations.create(user_id: user3.id)
    visit dashboard_path

    within '.hosting' do
      expect(page).to have_content("Parties that I'm Hosting!")
      expect(page).to have_content(party.movie_title)
      expect(page).to have_link("#{party.movie_title}")
      expect(page).to have_content("Date: Wednesday, July 14, 2021")
      expect(page).to have_content("Time: 07:00am")
      expect(page).to have_content("Length: 1 hr 21 min")
      expect(page).to have_content(user2.username)
      expect(page).to have_content(user3.username)
      expect(page).not_to have_content(user4.username)
    end
  end

  it "Has message if user is not hosting any parties" do
    user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship1 = Friendship.create(user_id: user.id, friend_id: user2.id)
    friendship2 = Friendship.create(user_id: user.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user.id, friend_id: user4.id)
    visit dashboard_path

    within '.hosting' do
      expect(page).to have_content("Parties that I'm Hosting!")
      expect(page).to have_content("You are not hosting any parties.")
    end
  end

  it "has a message if no frinds are invited" do
    user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship1 = Friendship.create(user_id: user.id, friend_id: user2.id)
    friendship2 = Friendship.create(user_id: user.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user.id, friend_id: user4.id)
    party = user.parties.create(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)
    visit dashboard_path

    within '.hosting' do
      expect(page).to have_content("Parties that I'm Hosting!")
      expect(page).to have_content(party.movie_title)
      expect(page).to have_link("#{party.movie_title}")
      expect(page).to have_content("Date: Wednesday, July 14, 2021")
      expect(page).to have_content("Time: 07:00am")
      expect(page).to have_content("Length: 1 hr 21 min")
      expect(page).not_to have_content(user2.username)
      expect(page).to have_content("No Friends Invited")
    end
  end

  it "Has a title that links to movie show page" do
    user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship1 = Friendship.create(user_id: user.id, friend_id: user2.id)
    friendship2 = Friendship.create(user_id: user.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user.id, friend_id: user4.id)
    party = user.parties.create(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)
    party.invitations.create(user_id: user2.id)
    party.invitations.create(user_id: user3.id)
    visit dashboard_path

    within '.hosting' do
      expect(page).to have_content("Parties that I'm Hosting!")
      expect(page).to have_content(party.movie_title)
      expect(page).to have_link("#{party.movie_title}")
      expect(page).to have_content("Date: Wednesday, July 14, 2021")
      expect(page).to have_content("Time: 07:00am")
      expect(page).to have_content("Length: 1 hr 21 min")
      click_on "#{party.movie_title}"
    end
    expect(current_path).to eq("/movies/862")
  end

  it "Displays parties the user is invited to" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship4 = Friendship.create(user_id: user2.id, friend_id: user.id)#user2 is the user with the friendships
    friendship5 = Friendship.create(user_id: user2.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user2.id, friend_id: user4.id)

    party = user2.parties.create!(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)
    party.invitations.create(user_id: user.id)#user2 creates party and invites user
    party.invitations.create(user_id: user3.id)

    visit dashboard_path
    within '.invited' do
      expect(page).to have_content("Parties that I'm Invited To!")
      expect(page).to have_content(party.movie_title)
      expect(page).to have_link("#{party.movie_title}")
      expect(page).to have_content("Date: Wednesday, July 14, 2021")
      expect(page).to have_content("Time: 07:00am")
      expect(page).to have_content("Length: 1 hr 21 min")
      expect(page).to have_content(user.username)#user1 is invited
      expect(page).to have_content(user3.username)
      expect(page).not_to have_content(user4.username)
    end
  end

  it "has message is user in not invited to any parties" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship4 = Friendship.create(user_id: user2.id, friend_id: user.id)#user2 is the user with the friendships
    friendship5 = Friendship.create(user_id: user2.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user2.id, friend_id: user4.id)
    party = user2.parties.create!(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)

    visit dashboard_path
    within '.invited' do
      expect(page).to have_content("Parties that I'm Invited To!")
      expect(page).to have_content("You are not invited to any parties.")
    end
  end

  it "Has a title that links to the movie show page" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    friendship4 = Friendship.create(user_id: user2.id, friend_id: user.id)#user2 is the user with the friendships
    friendship5 = Friendship.create(user_id: user2.id, friend_id: user3.id)
    friendship3 = Friendship.create(user_id: user2.id, friend_id: user4.id)

    party = user2.parties.create!(movie_title: "Toy Story", duration: "81", starts_at: Time.zone.parse("2021-07-14 01:00:00 -0600"), external_movie_id: 862)
    party.invitations.create(user_id: user.id)#user2 creates party and invites user
    party.invitations.create(user_id: user3.id)

    visit dashboard_path
    within '.invited' do
      expect(page).to have_content("Parties that I'm Invited To!")
      expect(page).to have_content(party.movie_title)
      expect(page).to have_link("#{party.movie_title}")
      expect(page).to have_content("Date: Wednesday, July 14, 2021")
      expect(page).to have_content("Time: 07:00am")
      expect(page).to have_content("Length: 1 hr 21 min")
      
      click_on "#{party.movie_title}"
    end
    expect(current_path).to eq("/movies/862")
  end
end
