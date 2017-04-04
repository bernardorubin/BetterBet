class CreateSoccerteams < ActiveRecord::Migration[5.0]
  def change
    create_table :soccerteams do |t|
      t.string :name
      t.integer :team_id

      t.timestamps
    end
  end
end
