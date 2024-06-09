class CreatePatientProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_profiles do |t|
      t.references :patient, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.text :medical_history
      t.date :date_of_birth
      t.string :blood_type
      t.text :allergies
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.string :insurance_provider

      t.timestamps
    end
  end
end
