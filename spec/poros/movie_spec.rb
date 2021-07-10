require 'rails_helper'

RSpec.describe Movie do
  before :each do
    json = File.read('./spec/fixtures/toy_story.json')
    movie_details = JSON.parse(json, symbolize_names: true)
    @movie = Movie.new(movie_details)  
  end

  it 'has basic details' do
    expect(@movie.title).to eq 'Toy Story'
    expect(@movie.vote_average).to eq 7.9
    expect(@movie.runtime).to eq 81
    expect(@movie.genres.length).to eq 4
    expect(@movie.genres.first[:name]).to eq 'Animation'
    expect(@movie.summary).to eq "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences."
  end
  
  it 'has cast and review info' do
    expect(@movie.cast_members.length).to eq 10
    expect(@movie.reviews.length).to eq 3
  end
end
