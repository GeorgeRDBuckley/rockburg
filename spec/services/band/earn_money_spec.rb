require 'rails_helper'

RSpec.describe Band::EarnMoney, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, manager: create(:manager) }

  it 'should add money to manager\'s account' do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)

    expect {
      described_class.call(band: band, amount: 123)
    }.to change { band.manager.balance }.by(123)
  end
end
