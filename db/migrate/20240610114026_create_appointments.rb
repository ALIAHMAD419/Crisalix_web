class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :patient, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.datetime :appointment_date
      t.string :status
      t.string :image1
      t.string :image2
      t.string :image3

      t.timestamps
    end
  end
end
