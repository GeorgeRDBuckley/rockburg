module Generator
  def self.band_name
    Faker::Hipster.sentence(2, false, 0).delete('.').titleize
  end

  def self.album_name
    Faker::Hipster.sentence(2, false, 0).delete('.').titleize
  end

  def self.song_title
    Faker::Hipster.sentence(2, false, 0).delete('.').titleize
  end
end
