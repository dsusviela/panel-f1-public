class Result < ApplicationRecord
  belongs_to :round
  belongs_to :driver

  def self.latest_round_results
    where(round: Round.latest_round)
  end

  def self.top_five_from_latest_round
    self.latest_round_results.order(:position).limit(5)
  end

  def self.dnf_from_latest_round
    from("(#{latest_round_results.to_sql}) as results").
      where('results.dnf = true').
      all()
  end

  def self.top_five(round)
    where(round: round).order(:position).limit(5)
  end

  def self.dnfs(round)
    where('results.dnf = true AND round_id = ?', round.id).all()
  end
end
