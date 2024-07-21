class ChangeVolumeInCars < ActiveRecord::Migration[7.1]
  def change
    rename_column :cars, :volune, :volume
  end
end
