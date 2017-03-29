class AddTickerToTickers < ActiveRecord::Migration[5.0]
  def change
    add_column :tickers, :ticker, :string
  end
end
