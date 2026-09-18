-- ============================================================
-- Dermatology Clinic Management System
-- Full MySQL Schema - 27 Tables
-- ============================================================


CREATE DATABASE dermatology_clinic
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE dermatology_clinic;

SELECT DATABASE();


USE dermatology_clinic;


-- ============================================================
-- 1. USERS
-- ==========================================================e==

CREATE TABLE users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(30) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,

    account_status ENUM(
        'active',
        'inactive',
        'suspended'
    ) NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. ROLES
-- ============================================================

CREATE TABLE roles (
    role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- ============================================================
-- 3. USER_ROLES
-- ============================================================

CREATE TABLE user_roles (
    user_role_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NOT NULL,
    role_id INT UNSIGNED NOT NULL,

    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (user_id, role_id),

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 4. PATIENTS
-- ============================================================

CREATE TABLE patients (
    patient_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NOT NULL UNIQUE,

    date_of_birth DATE,
    gender VARCHAR(30),
    address VARCHAR(255),
    emergency_contact VARCHAR(150),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 5. STAFF
-- ============================================================

CREATE TABLE staff (
    staff_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NOT NULL UNIQUE,

    employee_number VARCHAR(50) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    hire_date DATE,

    employment_status ENUM(
        'active',
        'inactive',
        'on_leave'
    ) NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 6. DOCTORS
-- ============================================================

CREATE TABLE doctors (
    doctor_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    staff_id INT UNSIGNED NOT NULL UNIQUE,

    specialty VARCHAR(120) NOT NULL,
    qualifications TEXT,
    years_of_experience TINYINT UNSIGNED,
    professional_bio TEXT,
    license_number VARCHAR(100) NOT NULL UNIQUE,

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 7. NURSES
-- ============================================================

CREATE TABLE nurses (
    nurse_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    staff_id INT UNSIGNED NOT NULL UNIQUE,

    department VARCHAR(100),
    license_number VARCHAR(100) NOT NULL UNIQUE,

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 8. SERVICES
-- ============================================================

CREATE TABLE services (
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    service_name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,

    duration_minutes SMALLINT UNSIGNED NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    service_status ENUM(
        'active',
        'inactive'
    ) NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (duration_minutes > 0),
    CHECK (price >= 0)
);


-- ============================================================
-- 9. DOCTOR_SERVICES
-- ============================================================

CREATE TABLE doctor_services (
    doctor_service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    doctor_id INT UNSIGNED NOT NULL,
    service_id INT UNSIGNED NOT NULL,

    UNIQUE (doctor_id, service_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- ============================================================
-- 10. OFFERS
-- ============================================================

CREATE TABLE offers (
    offer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    offer_name VARCHAR(150) NOT NULL,
    description TEXT,

    discount_type ENUM(
        'percentage',
        'fixed'
    ) NOT NULL,

    discount_value DECIMAL(10,2) NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    offer_status ENUM(
        'active',
        'inactive'
    ) NOT NULL DEFAULT 'active',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (discount_value >= 0),
    CHECK (end_date >= start_date),
    CHECK (
        discount_type <> 'percentage'
        OR discount_value <= 100
    )
);


-- ============================================================
-- 11. OFFER_SERVICES
-- ============================================================

CREATE TABLE offer_services (
    offer_service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    offer_id INT UNSIGNED NOT NULL,
    service_id INT UNSIGNED NOT NULL,

    UNIQUE (offer_id, service_id),

    FOREIGN KEY (offer_id)
        REFERENCES offers(offer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- ============================================================
-- 12. STAFF_SCHEDULES
-- ============================================================

CREATE TABLE staff_schedules (
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    staff_id INT UNSIGNED NOT NULL,

    day_of_week ENUM(
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
    ) NOT NULL,

    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    schedule_status ENUM(
        'active',
        'inactive'
    ) NOT NULL DEFAULT 'active',

    CHECK (end_time > start_time),

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- ============================================================
-- 13. APPOINTMENTS
-- ============================================================

CREATE TABLE appointments (
    appointment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    patient_id INT UNSIGNED NOT NULL,
    doctor_id INT UNSIGNED NOT NULL,
    nurse_id INT UNSIGNED NULL,
    service_id INT UNSIGNED NOT NULL,

    appointment_date DATE NOT NULL,

    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    appointment_status ENUM(
        'scheduled',
        'confirmed',
        'checked_in',
        'in_progress',
        'completed',
        'cancelled',
        'no_show'
    ) NOT NULL DEFAULT 'scheduled',

    booking_source ENUM(
        'patient',
        'receptionist',
        'admin'
    ) NOT NULL DEFAULT 'patient',

    created_by INT UNSIGNED NULL,

    cancellation_reason VARCHAR(255),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CHECK (end_time > start_time),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (nurse_id)
        REFERENCES nurses(nurse_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (created_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


-- ============================================================
-- 14. MEDICAL_RECORDS
-- ============================================================

CREATE TABLE medical_records (
    medical_record_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    patient_id INT UNSIGNED NOT NULL UNIQUE,

    allergies TEXT,
    medical_history TEXT,
    chronic_conditions TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 15. VISITS
-- ============================================================

CREATE TABLE visits (
    visit_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    appointment_id INT UNSIGNED NOT NULL UNIQUE,
    medical_record_id INT UNSIGNED NOT NULL,
    doctor_id INT UNSIGNED NOT NULL,

    visit_start DATETIME,
    visit_end DATETIME,

    chief_complaint TEXT,
    clinical_notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        visit_end IS NULL
        OR visit_start IS NULL
        OR visit_end >= visit_start
    ),

    FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (medical_record_id)
        REFERENCES medical_records(medical_record_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 16. DIAGNOSES
-- ============================================================

CREATE TABLE diagnoses (
    diagnosis_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    visit_id INT UNSIGNED NOT NULL,

    diagnosis_name VARCHAR(200) NOT NULL,
    diagnosis_code VARCHAR(50),

    description TEXT,

    diagnosed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 17. TREATMENT_PLANS
-- ============================================================

CREATE TABLE treatment_plans (
    treatment_plan_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    visit_id INT UNSIGNED NOT NULL,

    plan_description TEXT NOT NULL,

    start_date DATE,
    end_date DATE,

    plan_status ENUM(
        'planned',
        'active',
        'completed',
        'cancelled'
    ) NOT NULL DEFAULT 'planned',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        end_date IS NULL
        OR start_date IS NULL
        OR end_date >= start_date
    ),

    FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 18. PRESCRIPTIONS
-- ============================================================

CREATE TABLE prescriptions (
    prescription_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    visit_id INT UNSIGNED NOT NULL,
    doctor_id INT UNSIGNED NOT NULL,

    issued_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    general_instructions TEXT,

    FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 19. PRESCRIPTION_ITEMS
-- ============================================================

CREATE TABLE prescription_items (
    prescription_item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    prescription_id INT UNSIGNED NOT NULL,

    medication_name VARCHAR(200) NOT NULL,

    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration VARCHAR(100),

    instructions TEXT,

    FOREIGN KEY (prescription_id)
        REFERENCES prescriptions(prescription_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- ============================================================
-- 20. NURSING_NOTES
-- ============================================================

CREATE TABLE nursing_notes (
    nursing_note_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    visit_id INT UNSIGNED NOT NULL,
    nurse_id INT UNSIGNED NOT NULL,

    temperature DECIMAL(4,1),
    blood_pressure VARCHAR(20),
    weight DECIMAL(5,2),

    observations TEXT,
    note_text TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        temperature IS NULL
        OR temperature > 0
    ),

    CHECK (
        weight IS NULL
        OR weight > 0
    ),

    FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (nurse_id)
        REFERENCES nurses(nurse_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 21. FOLLOW_UPS
-- ============================================================

CREATE TABLE follow_ups (
    follow_up_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    visit_id INT UNSIGNED NOT NULL,

    recommended_date DATE,
    reason TEXT,

    follow_up_status ENUM(
        'recommended',
        'scheduled',
        'completed',
        'cancelled'
    ) NOT NULL DEFAULT 'recommended',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (visit_id)
        REFERENCES visits(visit_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 22. INVOICES
-- ============================================================

CREATE TABLE invoices (
    invoice_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    appointment_id INT UNSIGNED NOT NULL UNIQUE,
    patient_id INT UNSIGNED NOT NULL,

    subtotal DECIMAL(10,2) NOT NULL,

    discount_amount DECIMAL(10,2)
        NOT NULL DEFAULT 0.00,

    total_amount DECIMAL(10,2) NOT NULL,

    invoice_status ENUM(
        'unpaid',
        'partially_paid',
        'paid',
        'cancelled',
        'refunded'
    ) NOT NULL DEFAULT 'unpaid',

    issued_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (subtotal >= 0),
    CHECK (discount_amount >= 0),
    CHECK (total_amount >= 0),

    FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 23. PAYMENTS
-- ============================================================

CREATE TABLE payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    invoice_id INT UNSIGNED NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    payment_method ENUM(
        'cash',
        'card',
        'bank_transfer',
        'online'
    ) NOT NULL,

    payment_status ENUM(
        'pending',
        'completed',
        'failed',
        'refunded'
    ) NOT NULL DEFAULT 'pending',

    transaction_reference VARCHAR(150) UNIQUE,

    paid_at DATETIME,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (amount > 0),

    FOREIGN KEY (invoice_id)
        REFERENCES invoices(invoice_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ============================================================
-- 24. TASKS
-- ============================================================

CREATE TABLE tasks (
    task_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    assigned_to_staff_id INT UNSIGNED NOT NULL,
    assigned_by_staff_id INT UNSIGNED NULL,

    task_title VARCHAR(150) NOT NULL,
    task_description TEXT,

    priority ENUM(
        'low',
        'medium',
        'high',
        'urgent'
    ) NOT NULL DEFAULT 'medium',

    due_date DATETIME,

    task_status ENUM(
        'pending',
        'in_progress',
        'completed',
        'cancelled'
    ) NOT NULL DEFAULT 'pending',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    completed_at DATETIME,

    FOREIGN KEY (assigned_to_staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (assigned_by_staff_id)
        REFERENCES staff(staff_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


-- ============================================================
-- 25. NOTIFICATIONS
-- ============================================================

CREATE TABLE notifications (
    notification_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NOT NULL,

    notification_type ENUM(
        'appointment',
        'payment',
        'follow_up',
        'task',
        'system',
        'promotion'
    ) NOT NULL,

    title VARCHAR(150) NOT NULL,

    message TEXT NOT NULL,

    is_read BOOLEAN NOT NULL DEFAULT FALSE,

    sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    read_at DATETIME,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- ============================================================
-- 26. SYSTEM_SETTINGS
-- ============================================================

CREATE TABLE system_settings (
    setting_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    setting_key VARCHAR(100) NOT NULL UNIQUE,

    setting_value TEXT,

    updated_by INT UNSIGNED NULL,

    updated_at TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (updated_by)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);


-- ============================================================
-- 27. AUDIT_LOGS
-- ============================================================

CREATE TABLE audit_logs (
    audit_log_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id INT UNSIGNED NULL,

    action VARCHAR(100) NOT NULL,

    entity_name VARCHAR(100) NOT NULL,

    entity_id BIGINT UNSIGNED,

    action_details JSON,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

SHOW TABLES FROM dermatology_clinic;


-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_appointments_date
ON appointments(appointment_date);

CREATE INDEX idx_appointments_doctor_date
ON appointments(doctor_id, appointment_date);

CREATE INDEX idx_appointments_patient
ON appointments(patient_id);


-- ============================================================
-- DEFAULT ROLES
-- ============================================================

INSERT INTO roles (
    role_name,
    description
)
VALUES

('Patient', 'Clinic patient'),

('Doctor', 'Dermatology doctor'),

('Nurse', 'Clinic nurse'),

('Receptionist', 'Front desk and appointment management'),

('Employee', 'General clinic employee'),

('Supervisor', 'Operational supervisor'),

('Manager', 'Clinic manager'),

('Admin', 'System administrator');


SHOW TABLES FROM dermatology_clinic;