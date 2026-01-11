## 🏥 Hospital Management Database System
Designed for academic and learning purposes using **PostgreSQL**.
### 📌 Overview
This project implements a **Hospital Management Database System** using PostgreSQL. It manages patients, doctors, departments, appointments, appointment slots, and medical records. The system also includes stored functions and triggers to automate appointment availability and data retrieval.

### 🎯 Objectives
- Store and manage patient, doctor, and department information
- Schedule and track appointments
- Maintain medical records linked to appointments
- Manage doctor appointment slot availability automatically
- Provide search and reporting functions for medical and appointment data

### 🗂️ Database Tables
#### 1. patients
| Column Name | Data Type    | Description                |
| ----------- | ------------ | -------------------------- |
| patient_id  | SERIAL (PK)  | Unique patient identifier  |
| full_name   | VARCHAR(100) | Patient full name          |
| address     | VARCHAR(255) | Residential address        |
| dob         | DATE         | Date of birth              |
| insurance   | VARCHAR(50)  | Insurance provider         |
| username    | VARCHAR(50)  | Unique login username      |
| password    | VARCHAR(255) | Patient password           |
| email       | VARCHAR(100) | Email address              |
| telephone   | VARCHAR(15)  | Phone number               |
| dateleft    | DATE         | Date patient left (if any) |
#### 2. departments 
| Column Name     | Data Type    | Description                  |
| --------------- | ------------ | ---------------------------- |
| department_id   | SERIAL (PK)  | Unique department identifier |
| department_name | VARCHAR(100) | Name of department           |
#### 3. doctors 
| Column Name   | Data Type    | Description                            |
| ------------- | ------------ | -------------------------------------- |
| doctor_id     | SERIAL (PK)  | Unique doctor identifier               |
| full_name     | VARCHAR(100) | Doctor full name                       |
| department_id | INT (FK)     | References `departments.department_id` |
#### 4. appointment_slots
| Column Name      | Data Type   | Description                                      |
| ---------------- | ----------- | ------------------------------------------------ |
| doctor_id        | INT (FK)    | References `doctors.doctor_id`                   |
| slot_time        | TIME        | Appointment slot time                            |
| available_status | VARCHAR(25) | Slot availability (`Available`, `Not Available`) |
#### 5. appointments 
| Column Name      | Data Type   | Description                                              |
| ---------------- | ----------- | -------------------------------------------------------- |
| appointment_id   | SERIAL (PK) | Unique appointment identifier                            |
| patient_id       | INT (FK)    | References `patients.patient_id`                         |
| doctor_id        | INT (FK)    | References `doctors.doctor_id`                           |
| department_id    | INT (FK)    | References `departments.department_id`                   |
| appointment_date | DATE        | Date of appointment                                      |
| appointment_time | TIME        | Time of appointment                                      |
| status           | VARCHAR(20) | Appointment status (`Cancelled`, `Appointed`, `Expired`) |
#### 6. medical_records
| Column Name       | Data Type    | Description                              |
| ----------------- | ------------ | ---------------------------------------- |
| medical_record_id | SERIAL (PK)  | Unique medical record identifier         |
| patient_id        | INT (FK)     | References `patients.patient_id`         |
| appointment_id    | INT (FK)     | References `appointments.appointment_id` |
| diagnoses         | VARCHAR(255) | Diagnosis details                        |
| medicines         | VARCHAR(255) | Prescribed medicines                     |
| prescribed_date   | DATE         | Prescription date                        |
| allergies         | VARCHAR(255) | Known allergies                          |

### ER Diagram
<img width="1295" height="935" alt="Untitled" src="https://github.com/user-attachments/assets/eb0e7622-0e70-44e4-8266-11cfc9540b00" />

### ⚙️ Database Functions

#### medicines_info()
Searches medical records by medicine name (partial match).
<img width="684" height="486" alt="Screenshot 2026-01-11 222324" src="https://github.com/user-attachments/assets/dd94087e-5986-4526-8404-e97f7477b0ff" />

#### appointment_info()
Retrieves appointment and medical details for a specific date.
<img width="1276" height="414" alt="Screenshot 2026-01-11 222538" src="https://github.com/user-attachments/assets/cd92dafd-5671-4794-920a-fb9d55931c08" />
CREATE OR REPLACE FUNCTION appointment_info(dat DATE)
RETURNS TABLE (patnt_id INT, appoint DATE, appoint_time TIME, doct VARCHAR(100), diag VARCHAR(255), alerg VARCHAR(255) )
LANGUAGE plpgsql
AS 
$$
BEGIN
	RETURN QUERY
	SELECT mr.patient_id, apt.appointment_date, apt.appointment_time, d.full_name, mr.diagnoses, mr.allergies
	FROM medical_records AS mr
	JOIN appointments apt ON apt.appointment_id=mr.appointment_id
	JOIN doctors d ON apt.doctor_id=d.doctor_id
	WHERE apt.appointment_date=dat;
END;
$$;

SELECT * FROM appointment_info(dat := '2026-06-15');
