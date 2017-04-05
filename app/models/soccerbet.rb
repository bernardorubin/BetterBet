class Soccerbet < ApplicationRecord
  has_many :soccerteams
  attr_accessor :team

  has_many :user_soccerbets, dependent: :destroy
  has_many :users, through: :user_soccerbets

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :posted, :closed, :finished, :canceled, :in_progress

    event :post do
      transitions from: :draft, to: :posted
    end

    event :close do
      transitions from: :posted, to: :closed
    end

    event :cancel do
      transitions from: :posted, to: :canceled
    end

    # event :begin do
    #   transitions from: :taken, to: :in_progress
    # end

    event :finish do
      transitions from: :closed, to: :finished
    end

  end

end
