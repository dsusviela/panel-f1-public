class Score < ApplicationRecord
  belongs_to :user
  belongs_to :season
  belongs_to :round

  def self.in_current_season
    where(season_id: Season.current_season.id)
  end
end
