1. Boilerplate Setup:
    • Start with the Rails boilerplate that includes Ralix and Tailwind, using esbuild: Rails-Ralix-Tailwind Boilerplate.
2. Upgrade Ruby Version:
    • Upgrade the Ruby version as needed.
    • Add CSS and JS references to the manifest file.
3. Database Setup:
    • Implement Single Table Inheritance (STI) on the Users table, adding a type column to represent whether a user is a doctor or a patient. This approach avoids maintaining separate tables for different user types, centralizing authentication.
4. STI Logic:
    • Add logic for child tables Doctor and Patient to handle STI.
    • Create relationships for doctor and patient profiles to avoid populating the Users table with unrelated attributes. Profiles store unique attributes for doctors and patients, with access controls to ensure data privacy.
5. CRUD Functionality:
    • Implement CRUD operations for Doctor and Patient.
6. Password Management:
    • Implement password update functionality for both doctors and patients.
7. Email Handling:
    • Add the letter_opener gem to handle and preview forgotten password emails locally.
8. Appointments:
    • Create the Appointments table to connect doctors and patients.
    • Add validations for appointments to ensure data integrity.
    • Add carrierwave to upload the images in local
9. Testing Setup:
    • Integrate RSpec into the project along with necessary helper gems.
10. Model Test Cases:
    • Write test cases for all business logic in the models.
11. Controller Test Cases:
    • Write test cases for the ApplicationController to ensure correct functionality.
    • Write test cases for the DoctorController to ensure correct functionality.
    • Write test cases for the PatientController to ensure correct functionality.
    • Write test cases for the AppointmentController to ensure correct functionality.



Ruby Version: ruby 3.2.3
Rails Version: 7.0.8.1
--> Bundle install
--> Rails db:create
--> Rails db:migrate
--> Rails Server
