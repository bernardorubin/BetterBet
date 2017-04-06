class AddImageToTickers < ActiveRecord::Migration[5.0]
  def change
    add_column :tickers, :image, :string
  end
end
