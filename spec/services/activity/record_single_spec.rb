require 'rails_helper'

RSpec.describe Activity::RecordSingle, type: :service do
  let(:member1) { create(:member, primary_skill: Skill.find_by_name('Keyboards')) }
  let(:member2) { create(:member, primary_skill: Skill.find_by_name('Drummer')) }
  let(:genre) { Genre.find_by_style('Drum & Bass') }
  let(:band) { create :band, genre: genre }
  let(:song) { create :song, band: band }
  let(:studio) { create :studio, cost: 1000}

  before do
    band.add_member(member1, skill: member1.primary_skill)
    band.add_member(member2, skill: member2.primary_skill)
  end

  it 'should record a single' do
    balance = band.manager.balance
    expect {
      Sidekiq::Testing.inline! do
        result = described_class.call(band: band, song: song, studio: studio)
        expect(result.success?).to eq(true)
        expect(result.activity).to be_present
      end
    }.to change { band.recordings.count }.by(1)
    band.manager.reload
    expect(balance).to be > band.manager.balance
  end
end
