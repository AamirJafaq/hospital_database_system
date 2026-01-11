/* Search the database of the hospital for matching character strings by name of medicine. 
Results should be sorted with most recent medicine prescribed date first. 
*/
TRUNCATE TABLE medical_records RESTART IDENTITY CASCADE;
SELECT * FROM medical_records;


CREATE OR REPLACE FUNCTION medicines_info(med_name VARCHAR(50))
RETURNS TABLE (pat_id INT , med VARCHAR(255), pre_date DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT p.patient_id, mr.medicines, mr.prescribed_date
    FROM medical_records AS mr
	JOIN patients AS p ON p.patient_id=mr.patient_id
    WHERE mr.medicines ILIKE '%' || med_name || '%'
    ORDER BY prescribed_date DESC;
END;
$$;

SELECT * FROM medicines_info('anti');

/* Return a full list of doctor name, time, diagnosis and allergies for a specific patient 
who has an appointment at a specific date.
*/

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



/*  Create a function that results the doctors name, department, timing and 
available status.
*/

CREATE OR REPLACE FUNCTION appointment_availability()
RETURNS TABLE (doc_name VARCHAR(100), depart_id INT, timing TIME, status VARCHAR(25))
LANGUAGE plpgsql
AS
$$
BEGIN
	RETURN QUERY
	SELECT d.full_name, d.department_id, apslt.slot_time, apslt.available_status
	FROM appointment_slots AS apslt
	RIGHT JOIN doctors AS d ON apslt.doctor_id=d.doctor_id
	WHERE apslt.available_status = 'Available';
END;
$$;

SELECT * FROM appointment_availability();

/*  Create a trigger so that the appointment slot status can be change to
availale when appointment is status is cancelled and expired.
*/

SELECT * FROM appointments;

CREATE OR REPLACE FUNCTION slot_availability()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS
$$
BEGIN
	IF NEW.status IN ('Expired', 'Cancelled') THEN
	UPDATE appointment_slots
	SET available_status = 'Available'
	WHERE doctor_id = NEW.doctor_id;
	END IF;
	RETURN NEW;
END;
$$;

CREATE TRIGGER slot_availability_trigger
BEFORE UPDATE ON appointments
FOR EACH ROW
EXECUTE PROCEDURE slot_availability();


