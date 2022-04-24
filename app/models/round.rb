class Round < ApplicationRecord
  belongs_to :season
  has_many :results
  has_many :results

  def self.current_season
    where(season_id: Season.current_season.id)
  end

  def self.remaining_rounds_of_current_season
    merge(current_season).where('date > ?', Time.zone.now)
  end

  def self.latest_round
    from("(#{current_season.to_sql}) as rounds").
      where('rounds.date <= ?', Time.zone.now).
      order('rounds.date DESC').
      limit(1).
      first
  end
end
