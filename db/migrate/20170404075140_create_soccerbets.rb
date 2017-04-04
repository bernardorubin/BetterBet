class CreateSoccerbets < ActiveRecord::Migration[5.0]
  def change
    create_table :soccerbets do |t|
      t.integer :user_id1
      t.integer :user_id2
      t.integer :team_id1
      t.integer :team_id2
      t.integer :winner
      t.integer :fixture_id
      t.datetime :fixture_date

      t.timestamps
    end
  end
end
