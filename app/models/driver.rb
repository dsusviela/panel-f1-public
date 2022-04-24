class Driver < ApplicationRecord
  include FavoriteF1Entity

  belongs_to :team
  belongs_to :season
  belongs_to :country
  has_many :results
  has_many :rounds, through: :results

  def self.current_season
    where(season_id: Season.current_season.id)
  end
end
