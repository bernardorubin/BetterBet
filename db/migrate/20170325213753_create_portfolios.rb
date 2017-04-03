class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.float :startvalue, array: true, default: []
      t.float :currentvalue, array: true, default:[]
      t.datetime :startdate
      t.datetime :enddate
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
