class AddDefaultValueToTimezone < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :timezone, :string, default: 'America/Los_Angeles'
  end
end
