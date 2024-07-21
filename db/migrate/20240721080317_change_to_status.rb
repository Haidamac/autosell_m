class ChangeToStatus < ActiveRecord::Migration[7.1]
  def change
    change_column :cars, :status, :integer, default: 0
  end
end
