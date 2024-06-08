class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.date :date_of_birth
      t.string :blood_type
      t.text :medical_history
      t.text :allergies
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.string :insurance_provider

      t.timestamps
    end
  end
end
