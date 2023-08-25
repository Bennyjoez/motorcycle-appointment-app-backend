class CreateMotorcycles < ActiveRecord::Migration[7.0]
  def change
    create_table :motorcycles do |t|
      t.string :name
      t.string :image
      t.float :amount
      t.integer :duration

      t.timestamps
    end
  end
end
