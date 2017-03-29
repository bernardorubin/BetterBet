class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps
    end
  end
end
