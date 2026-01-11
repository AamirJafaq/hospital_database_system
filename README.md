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
#### patients
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
