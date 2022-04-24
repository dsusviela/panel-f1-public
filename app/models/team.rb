class Team < ApplicationRecord
  include FavoriteF1Entity

  belongs_to :season
end
