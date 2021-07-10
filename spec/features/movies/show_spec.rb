require 'rails_helper'

RSpec.describe 'movie show page' do
  before :each do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    response_body = File.read('./spec/fixtures/toy_story.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/862?api_key=#{ENV['MOVIE_DB_KEY']}&language=en")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body, headers: {})

    visit '/movies/862'
  end

  it 'displays the movie title' do
    expect(page).to have_content 'Toy Story'
  end

  it 'displays basic movie details' do
    expect(page).to have_content 'Vote average: 7.9'
    expect(page).to have_content 'Runtime: 1 hr 21 min'
    expect(page).to have_content 'Genre(s): Animation, Adventure, Family, Comedy'
    expect(page).to have_content "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences."
  end

  it 'displays the first 10 cast members' do
    expect(page).to have_content 'Tom Hanks, Tim Allen, Don Rickles, Jim Varney, Wallace Shawn, John Ratzenberger, Annie Potts, John Morris, Erik von Detten, Laurie Metcalf'
  end

  it 'displays all reviews with their authors' do
    expect(page).to have_content '3 Reviews'
    expect(page).to have_content "Author: Gimly"
    expect(page).to have_content "Author: JPV852"
    expect(page).to have_content "Author: r96sk"
    expect(page).to have_content "This movie came out when I was three. Now I'm twenty seven and the goddamn thing still holds up.\r \r _Final rating:★★★★ - Very strong appeal. A personal favourite._"
    expect(page).to have_content "Decided to revisit this after many years and still holds up so well. Great movie for both kids and adults with wonderful teachable moments. Just a groundbreaking animated movie all around. **4.5/5**"
    expect(page).to have_content "A stunning feature film entrance from Pixar! <em>'Toy Story'</em> is a true delight, from the first second to the last.\r \r The CGI animation is excellent. All the toys look brilliant, as does the world itself - I love the feel of it. The music is very good, Randy Newman does a nice job - \"You've Got a Friend in Me\" is a cracker.\r \r Tom Hanks leads a strong cast. Hanks plays Woody, to fantastic effect. He is the best part of this film. Tim Allen is great, too, as Buzz Lightyear. Don Rickles (Mr. Potato Head), Wallace Shawn (Rex) and John Ratzenberger (Hamm) also bring fun.\r \r Everything else is just as terrific: the humour, the pacing, the plot - I enjoy it all. There are probably some flaws in parts, namely Buzz's supposed unawareness, but nothing impacts the viewing experience. Go watch!"
  end

  it 'has a link to create a viewing party' 
end
