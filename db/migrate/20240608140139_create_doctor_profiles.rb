class CreateDoctorProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_profiles do |t|
      t.references :doctor, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.string :specialty
      t.text :bio

      t.timestamps
    end
  end
end
