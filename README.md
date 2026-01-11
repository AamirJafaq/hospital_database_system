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
#### 2. doctors 
| Column Name   | Data Type    | Description                            |
| ------------- | ------------ | -------------------------------------- |
| doctor_id     | SERIAL (PK)  | Unique doctor identifier               |
| full_name     | VARCHAR(100) | Doctor full name                       |
| department_id | INT (FK)     | References `departments.department_id` |
#### 2. appointment_slots
| Column Name      | Data Type   | Description                                      |
| ---------------- | ----------- | ------------------------------------------------ |
| doctor_id        | INT (FK)    | References `doctors.doctor_id`                   |
| slot_time        | TIME        | Appointment slot time                            |
| available_status | VARCHAR(25) | Slot availability (`Available`, `Not Available`) |
#### 2. appointments 
| Column Name      | Data Type   | Description                                              |
| ---------------- | ----------- | -------------------------------------------------------- |
| appointment_id   | SERIAL (PK) | Unique appointment identifier                            |
| patient_id       | INT (FK)    | References `patients.patient_id`                         |
| doctor_id        | INT (FK)    | References `doctors.doctor_id`                           |
| department_id    | INT (FK)    | References `departments.department_id`                   |
| appointment_date | DATE        | Date of appointment                                      |
| appointment_time | TIME        | Time of appointment                                      |
| status           | VARCHAR(20) | Appointment status (`Cancelled`, `Appointed`, `Expired`) |
#### 2. medical_records
| Column Name       | Data Type    | Description                              |
| ----------------- | ------------ | ---------------------------------------- |
| medical_record_id | SERIAL (PK)  | Unique medical record identifier         |
| patient_id        | INT (FK)     | References `patients.patient_id`         |
| appointment_id    | INT (FK)     | References `appointments.appointment_id` |
| diagnoses         | VARCHAR(255) | Diagnosis details                        |
| medicines         | VARCHAR(255) | Prescribed medicines                     |
| prescribed_date   | DATE         | Prescription date                        |
| allergies         | VARCHAR(255) | Known allergies                          |


PATIENTS
---------
patient_id (PK)
full_name
dob
insurance
username
email
telephone
    |
    | 1
    |------< APPOINTMENTS >------| 1
                    appointment_id (PK)
                    appointment_date
                    appointment_time
                    status
                    patient_id (FK)
                    doctor_id (FK)
                    department_id (FK)
                               |
                               | 1
                               |------ DOCTORS
                                        doctor_id (PK)
                                        full_name
                                        department_id (FK)
                                             |
                                             | M
                                             |------ DEPARTMENTS
                                                      department_id (PK)
                                                      department_name

DOCTORS
   |
   | 1
   |------< APPOINTMENT_SLOTS
              doctor_id (FK)
              slot_time
              available_status


APPOINTMENTS
     |
     | 1
     |------ MEDICAL_RECORDS
              medical_record_id (PK)
              diagnoses
              medicines
              prescribed_date
              allergies
