class AddImageToSoccerteams < ActiveRecord::Migration[5.0]
  def change
    add_column :soccerteams, :image, :string
  end
end
