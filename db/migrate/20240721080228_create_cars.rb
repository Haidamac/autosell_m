class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :car_model
      t.string :body
      t.decimal :mileage
      t.string :color
      t.decimal :price
      t.string :fuel
      t.integer :year
      t.decimal :volune
      t.integer :status

      t.timestamps
    end
  end
end
