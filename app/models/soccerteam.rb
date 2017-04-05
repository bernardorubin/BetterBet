class Soccerteam < ApplicationRecord
  belongs_to :soccerbets

  validates :team_id, uniqueness: true, presence: true
  validates :name, uniqueness: true, presence: true
end
