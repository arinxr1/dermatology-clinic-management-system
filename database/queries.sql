-- ============================================================
-- Dermatology Clinic Management System
-- Queries & Reports
-- ============================================================

USE dermatology_clinic;


-- ============================================================
-- SECTION 1: BASIC QUERIES
-- ============================================================


-- 1. Show all users
SELECT
    user_id,
    full_name,
    email,
    phone,
    account_status
FROM users
ORDER BY user_id;


-- 2. Show users with their roles
SELECT
    u.user_id,
    u.full_name,
    u.email,
    r.role_name
FROM users u
JOIN user_roles ur
    ON u.user_id = ur.user_id
JOIN roles r
    ON ur.role_id = r.role_id
ORDER BY u.user_id;


-- 3. Show all patients
SELECT
    p.patient_id,
    u.full_name AS patient_name,
    u.email,
    u.phone,
    p.date_of_birth,
    p.gender,
    p.address
FROM patients p
JOIN users u
    ON p.user_id = u.user_id
ORDER BY p.patient_id;


-- 4. Show all clinic staff
SELECT
    s.staff_id,
    u.full_name,
    s.employee_number,
    s.job_title,
    s.hire_date,
    s.employment_status
FROM staff s
JOIN users u
    ON s.user_id = u.user_id
ORDER BY s.staff_id;


-- ============================================================
-- SECTION 2: DOCTORS & SERVICES
-- ============================================================


-- 5. Show doctors and their specialties
SELECT
    d.doctor_id,
    u.full_name AS doctor_name,
    d.specialty,
    d.years_of_experience,
    d.license_number
FROM doctors d
JOIN staff s
    ON d.staff_id = s.staff_id
JOIN users u
    ON s.user_id = u.user_id
ORDER BY d.doctor_id;


-- 6. Show services provided by each doctor
SELECT
    u.full_name AS doctor_name,
    d.specialty,
    sv.service_name,
    sv.duration_minutes,
    sv.price
FROM doctor_services ds
JOIN doctors d
    ON ds.doctor_id = d.doctor_id
JOIN staff st
    ON d.staff_id = st.staff_id
JOIN users u
    ON st.user_id = u.user_id
JOIN services sv
    ON ds.service_id = sv.service_id
ORDER BY doctor_name, sv.service_name;


-- ============================================================
-- SECTION 3: APPOINTMENTS
-- ============================================================


-- 7. Detailed appointment list
SELECT
    a.appointment_id,
    pu.full_name AS patient_name,
    du.full_name AS doctor_name,
    nu.full_name AS nurse_name,
    sv.service_name,
    a.appointment_date,
    a.start_time,
    a.end_time,
    a.appointment_status,
    a.booking_source
FROM appointments a

JOIN patients p
    ON a.patient_id = p.patient_id
JOIN users pu
    ON p.user_id = pu.user_id

JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN staff ds
    ON d.staff_id = ds.staff_id
JOIN users du
    ON ds.user_id = du.user_id

LEFT JOIN nurses n
    ON a.nurse_id = n.nurse_id
LEFT JOIN staff ns
    ON n.staff_id = ns.staff_id
LEFT JOIN users nu
    ON ns.user_id = nu.user_id

JOIN services sv
    ON a.service_id = sv.service_id

ORDER BY
    a.appointment_date,
    a.start_time;


-- 8. Number of appointments by status
SELECT
    appointment_status,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY appointment_status
ORDER BY total_appointments DESC;


-- 9. Number of appointments for each doctor
SELECT
    u.full_name AS doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN staff s
    ON d.staff_id = s.staff_id
JOIN users u
    ON s.user_id = u.user_id
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_id,
    u.full_name
ORDER BY total_appointments DESC;


-- 10. Upcoming scheduled or confirmed appointments
SELECT
    a.appointment_id,
    pu.full_name AS patient_name,
    du.full_name AS doctor_name,
    sv.service_name,
    a.appointment_date,
    a.start_time,
    a.appointment_status
FROM appointments a

JOIN patients p
    ON a.patient_id = p.patient_id
JOIN users pu
    ON p.user_id = pu.user_id

JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN staff st
    ON d.staff_id = st.staff_id
JOIN users du
    ON st.user_id = du.user_id

JOIN services sv
    ON a.service_id = sv.service_id

WHERE a.appointment_status IN ('scheduled', 'confirmed')

ORDER BY
    a.appointment_date,
    a.start_time;


    -- ============================================================
-- SECTION 4: MEDICAL QUERIES
-- ============================================================


-- 11. Completed visits with diagnoses
SELECT
    v.visit_id,
    u.full_name AS patient_name,
    du.full_name AS doctor_name,
    v.visit_start,
    v.chief_complaint,
    d.diagnosis_name,
    d.description AS diagnosis_description
FROM visits v

JOIN medical_records mr
    ON v.medical_record_id = mr.medical_record_id

JOIN patients p
    ON mr.patient_id = p.patient_id

JOIN users u
    ON p.user_id = u.user_id

JOIN doctors doc
    ON v.doctor_id = doc.doctor_id

JOIN staff st
    ON doc.staff_id = st.staff_id

JOIN users du
    ON st.user_id = du.user_id

LEFT JOIN diagnoses d
    ON v.visit_id = d.visit_id

ORDER BY v.visit_start;


-- 12. Treatment plans for patients
SELECT
    u.full_name AS patient_name,
    d.diagnosis_name,
    tp.plan_description,
    tp.start_date,
    tp.end_date,
    tp.plan_status
FROM treatment_plans tp

JOIN visits v
    ON tp.visit_id = v.visit_id

JOIN medical_records mr
    ON v.medical_record_id = mr.medical_record_id

JOIN patients p
    ON mr.patient_id = p.patient_id

JOIN users u
    ON p.user_id = u.user_id

LEFT JOIN diagnoses d
    ON v.visit_id = d.visit_id

ORDER BY tp.start_date;


-- 13. Patient prescriptions and medications
SELECT
    u.full_name AS patient_name,
    pr.prescription_id,
    pi.medication_name,
    pi.dosage,
    pi.frequency,
    pi.duration,
    pi.instructions,
    pr.issued_at
FROM prescriptions pr

JOIN visits v
    ON pr.visit_id = v.visit_id

JOIN medical_records mr
    ON v.medical_record_id = mr.medical_record_id

JOIN patients p
    ON mr.patient_id = p.patient_id

JOIN users u
    ON p.user_id = u.user_id

JOIN prescription_items pi
    ON pr.prescription_id = pi.prescription_id

ORDER BY
    u.full_name,
    pr.prescription_id;


-- 14. Nursing notes for completed visits
SELECT
    v.visit_id,
    pu.full_name AS patient_name,
    nu.full_name AS nurse_name,
    nn.temperature,
    nn.blood_pressure,
    nn.weight,
    nn.observations,
    nn.note_text
FROM nursing_notes nn

JOIN visits v
    ON nn.visit_id = v.visit_id

JOIN medical_records mr
    ON v.medical_record_id = mr.medical_record_id

JOIN patients p
    ON mr.patient_id = p.patient_id

JOIN users pu
    ON p.user_id = pu.user_id

JOIN nurses n
    ON nn.nurse_id = n.nurse_id

JOIN staff ns
    ON n.staff_id = ns.staff_id

JOIN users nu
    ON ns.user_id = nu.user_id

ORDER BY v.visit_id;


-- 15. Patient follow-up recommendations
SELECT
    u.full_name AS patient_name,
    fu.recommended_date,
    fu.reason,
    fu.follow_up_status
FROM follow_ups fu

JOIN visits v
    ON fu.visit_id = v.visit_id

JOIN medical_records mr
    ON v.medical_record_id = mr.medical_record_id

JOIN patients p
    ON mr.patient_id = p.patient_id

JOIN users u
    ON p.user_id = u.user_id

ORDER BY fu.recommended_date;