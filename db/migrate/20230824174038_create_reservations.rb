class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :vehicle_app
      t.string :model_name
      t.integer :user_id
      t.date :date
      t.string :city
      t.string :status

      t.timestamps
    end
  end
end