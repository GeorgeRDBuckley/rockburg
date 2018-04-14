# == Schema Information
#
# Table name: activities
#
#  id         :bigint(8)        not null, primary key
#  action     :string
#  ends_at    :datetime
#  starts_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#
# Indexes
#
#  index_activities_on_band_id  (band_id)
#

class Activity < ApplicationRecord
  belongs_to :band
  belongs_to :financial, optional: true

  def self.current_activity
    where('ends_at > ?', Time.now)
  end

  ACTIVITIES = {
    'practice' => 'Practicing',
    'write_song' => 'Writing a song',
    'gig'=> 'Playing a gig',
    'record_single' => 'Recording a single',
    'record_album' => 'Recording an album',
    'release' => 'Releasing music',
    'rest' => 'Resting'
  }.freeze

  def humanize_action
    ACTIVITIES[action]
  end
end
