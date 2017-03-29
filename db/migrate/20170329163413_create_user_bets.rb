class CreateUserBets < ActiveRecord::Migration[5.0]
  def change
    create_table :user_bets do |t|
      t.references :user, foreign_key: true, index: true
      t.references :bet, foreign_key: true, index: true

      t.timestamps
    end
  end
end
