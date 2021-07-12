require 'rails_helper'

RSpec.describe Party do
  describe 'relationships' do
    it {should belong_to :user}
  end
end
