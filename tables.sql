-- creating patients table.
DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    insurance VARCHAR(50) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    telephone VARCHAR(15),
    dateleft DATE
);

-- Creating department table
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

--Creating doctors table
DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_doctors_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

DROP TABLE IF EXISTS appointment_slots;
CREATE TABLE appointment_slots (

);

-- Creating appointment_slots table
DROP TABLE IF EXISTS appointment_slots;
CREATE TABLE appointment_slots (
	doctor_id INT NOT NULL, 
	slot_time TIME, 
	available_status VARCHAR(25), 
	CONSTRAINT fk_appoint_slots_doctor_id FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
	CONSTRAINT check_available_status CHECK (available_status IN ('Available', 'Not Available'))
);


-- Creating appoitments table
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Cancelled', 'Appointed', 'Expired')),
    CONSTRAINT fk_appointments_patient_id FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
	CONSTRAINT fk_appointments_doctor_id FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
	CONSTRAINT fk_appointments_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id),
	CONSTRAINT check_appoitment_date CHECK (appointment_date >= CURRENT_DATE)
);


-- Creating medical records
DROP TABLE IF EXISTS medical_records;
CREATE TABLE medical_records (
    medical_record_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    diagnoses VARCHAR(255),
    medicines VARCHAR(255),
    prescribed_date DATE,
    allergies VARCHAR(255),
    CONSTRAINT fk_medical_records_patient_id FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    CONSTRAINT fk_medical_records_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

