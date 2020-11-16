require 'rails_helper'

RSpec.describe Activity::PlayGig, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre, fans: 300, buzz: 300 }
  let(:venue) { create :venue, capacity: 250 }

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
  end

  it 'should rest a bit' do
    m1_before = member1.trait_fatigue
    m2_before = member2.trait_fatigue

    expect {
      Sidekiq::Testing.inline! do
        result = described_class.call(band: band, venue: venue, hours: 6)
        expect(result.success?).to eq(true)
        expect(result.activity).to be_present
      end
    }.to change { band.gigs.count }.by(1)

    member1.reload
    member2.reload
    expect(member1.trait_fatigue).to be > m1_before
    expect(member2.trait_fatigue).to be > m2_before
  end
end
