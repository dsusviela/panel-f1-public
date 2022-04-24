class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :round
  belongs_to :first, class_name: 'Driver'
  belongs_to :second, class_name: 'Driver'
  belongs_to :third, class_name: 'Driver'
  belongs_to :fourth, class_name: 'Driver'
  belongs_to :fifth, class_name: 'Driver'
  belongs_to :dnf, class_name: 'Driver'

  def self.latest_round_predictions
    where(round: Round.latest_round)
  end

  def self.calculate_points(prediction, dnfs, top_five)
    points = 0

    if prediction.first == top_five[0].driver
      points = ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i
    end

    if prediction.second == top_five[1].driver
      points += ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i
    end

    if prediction.third == top_five[2].driver
      points += ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i
    end

    if prediction.fourth == top_five[3].driver
      points += ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i
    end

    if prediction.fifth == top_five[4].driver
      points += ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i
    end

    if dnfs.map(&:driver).include?(prediction.dnf)
      points += ENV["POINTS_CORRECT_DNF_PREDICTION"].to_i
    end

    if points == ENV["POINTS_CORRECT_POSITION_PREDICTION"].to_i * 5 + ENV["POINTS_CORRECT_DNF_PREDICTION"].to_i
      points = ENV["POINTS_MAX"].to_i
    end

    points
  end

  def self.latest_prediction_for_user(user:)
    where(user: user).joins(:round).order(created_at: :desc).limit(1).first
  end

  def self.latest_round_prediction_for(user:)
    where(user: user).joins(:round).where(round_id: Round.latest_round.id).limit(1).first
  end

  def self.next_round_prediction_for(user:)
    where(user: user)
      .joins(:round)
      .where(round_id: Round.remaining_rounds_of_current_season.first.id)
      .limit(1)
      .first
  end

  def drivers
    {
      top_five: [first, second, third, fourth, fifth],
      dnf: dnf
    }
  end
end
