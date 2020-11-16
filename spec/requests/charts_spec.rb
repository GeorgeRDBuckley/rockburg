require 'rails_helper'

RSpec.describe "Charts", type: :request do
  describe "INDEX" do
    before do
      3.times do
        create :manager
      end
      6.times do
        if rand(100) > 50
          Manager::EarnMoney.(manager: Manager.all.sample, amount: rand(1..10) * 100)
        else
          Manager::SpendMoney.(manager: Manager.all.sample, amount: rand(1..10) * 100)
        end
      end
    end

    it "sanity check" do
      get charts_path
      expect(response).to have_http_status(200)
    end
  end
end
