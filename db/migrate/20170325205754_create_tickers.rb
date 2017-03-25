class CreateTickers < ActiveRecord::Migration[5.0]
  def change
    create_table :tickers do |t|
      t.string :ticker
      t.references :portfolio, foreign_key: true, index: true

      t.timestamps
    end
  end
end
