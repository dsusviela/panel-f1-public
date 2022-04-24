module PredictionsHelper
  def self.serialize_team_name_for_color(team)
    team.name.split(' ').join.downcase
  end
end
