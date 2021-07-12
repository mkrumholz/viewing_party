require 'rails_helper'

RSpec.describe ViewingParty do
  describe 'relationships' do
    it {should belong_to :user}
  end
end
