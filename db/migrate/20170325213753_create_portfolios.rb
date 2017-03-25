class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.float :startvalue
      t.float :currentvalue
      t.datetime :startdate
      t.datetime :enddate
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
