class Season < ApplicationRecord
  has_many :scores

  def self.current_season
    find_by(year: ENV["CURRENT_SEASON"])
  end
end
