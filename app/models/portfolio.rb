class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio_tickers
end
