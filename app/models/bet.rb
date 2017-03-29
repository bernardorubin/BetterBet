class Bet < ApplicationRecord
  has_many :portfolios
  attr_accessor :portfolio
  scope :latest_first, -> {order(created_at: :desc)}


  def self.distance_between(start_date, end_date)
    difference = end_date.to_i - start_date.to_i
    seconds    =  difference % 60
    difference = (difference - seconds) / 60
    minutes    =  difference % 60
    difference = (difference - minutes) / 60
    hours      =  difference % 24
    difference = (difference - hours)   / 24
    days       =  difference % 7
    weeks      = (difference - days)    /  7

    return "#{hours} hours, #{minutes} minutes, #{seconds} seconds"
  end

end
