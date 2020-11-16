# == Schema Information
#
# Table name: game_data
#
#  id         :bigint(8)        not null, primary key
#  key        :string
#  value      :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_game_data_on_key  (key) UNIQUE
#

class GameDatum < ApplicationRecord
  def self.get(key)
    self.where(key: key).first&.value
  end

  def self.set(key, value)
    record = self.where(key: key).first_or_create
    record.update(value: value)
  end
end
