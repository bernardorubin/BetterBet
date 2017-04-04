class Soccerbet < ApplicationRecord
  has_many :soccerteams
  attr_accessor :team


  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :posted, :closed, :in_progress, :finished, :canceled

    event :post do
      transitions from: :draft, to: :posted
    end

    event :close do
      transitions from: :posted, to: :closed
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

end
