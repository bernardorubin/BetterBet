class Bet < ApplicationRecord
  has_many :portfolios
  attr_accessor :portfolio
  scope :latest_first, -> {order(created_at: :desc)}
  validates :amount, presence: true
  
  has_many :user_soccerbets, dependent: :destroy
  has_many :soccerbets, through: :user_soccerbets


  include AASM

  aasm whiny_transitions: false do
    state :posted, initial: true
    state :taken, :in_progress, :finished, :canceled

    event :close do
      transitions from: :posted, to: :taken
    end

    event :cancel do
      transitions from: :posted, to: :canceled
    end

    event :begin do
      transitions from: :taken, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :finished
    end

  end

  # def self.distance_between(start_date, end_date)
  #   difference = end_date.to_i - start_date.to_i
  #   seconds    =  difference % 60
  #   difference = (difference - seconds) / 60
  #   minutes    =  difference % 60
  #   difference = (difference - minutes) / 60
  #   hours      =  difference % 24
  #   difference = (difference - hours)   / 24
  #   days       =  difference % 7
  #   weeks      = (difference - days)    /  7
  #
  #   return "#{hours} hours, #{minutes} minutes, #{seconds} seconds"
  # end

end
