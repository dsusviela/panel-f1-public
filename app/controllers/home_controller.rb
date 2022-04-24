class HomeController < ApplicationController
  def index
    @ordered_scores = Score
      .in_current_season
      .includes(user: [:country, :favorite_f1_entity])
      .group(:user_id)
      .order('score_sum DESC')
      .limit(15)
      .select("scores.user_id, sum(scores.score) as score_sum")
  end
end
