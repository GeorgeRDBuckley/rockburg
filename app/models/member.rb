# == Schema Information
#
# Table name: members
#
#  id                    :bigint(8)        not null, primary key
#  birthdate             :date
#  cost                  :integer          default(0), not null
#  gender                :string           default("")
#  name                  :string           default("")
#  skill_primary         :integer
#  skill_primary_level   :integer          default(0)
#  skill_secondary       :integer
#  skill_secondary_level :integer          default(0)
#  skill_tertiary        :integer
#  skill_tertiary_level  :integer          default(0)
#  trait_aptitude        :integer          default(0), not null
#  trait_creativity      :integer          default(0), not null
#  trait_drive           :integer          default(0), not null
#  trait_ego             :integer          default(0), not null
#  trait_fatigue         :integer          default(0), not null
#  trait_looks           :integer          default(0), not null
#  trait_network         :integer          default(0), not null
#  trait_productivity    :integer          default(0), not null
#  trait_stamina         :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Member < ApplicationRecord
  ## -- RELATIONSHIPS
  belongs_to :primary_skill, class_name: 'Skill', foreign_key: :skill_primary
  belongs_to :secondary_skill, class_name: 'Skill', foreign_key: :skill_secondary, optional: true
  belongs_to :tertiary_skill, class_name: 'Skill', foreign_key: :skill_tertiary, optional: true
  has_many :member_bands
  has_many :bands, through: :member_bands

  ## -- SCOPES
  scope :with_skill, ->(skill) { where("skill_primary = :skill_id OR skill_secondary = :skill_id OR skill_tertiary = :skill_id", skill_id: Skill.ensure(skill).id)}

  ## — INSTANCE METHODS
  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - (now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day) ? 0 : 1)
  end

  GENDER_MAP = {
    'M' => 'male',
    'F' => 'female',
  }.freeze
  def gender
    GENDER_MAP[super] || super
  end

  def cost_generator
    # NOTE: placeholder until all calls to member.cost_generator can be replaced with Member::CostGenerator.(member: m).result
    Member::CostGenerator.(member: self).result
  end

  def avatar_url
    # NOTE: placeholder until all calls to member.cost_generator can be replaced with Member::AvatarURL.(member: m).result
    Member::AvatarURL.(member: self).result
  end
end
