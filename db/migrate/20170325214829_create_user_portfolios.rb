class CreateUserPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :user_portfolios do |t|
      t.references :user, foreign_key: true, index: true
      t.references :portfolio, foreign_key: true, index: true

      t.timestamps
    end
  end
end
