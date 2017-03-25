class CreatePortfolioTickers < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_tickers do |t|
      t.references :portfolio, foreign_key: true, index: true
      t.references :tickers, foreign_key: true, index: true

      t.timestamps
    end
  end
end
