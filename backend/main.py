from fastapi import FastAPI

from database import get_connection

app = FastAPI(title="Dermatology Clinic API")


@app.get("/")
def home():
    return {
        "message": "Welcome to Dermatology Clinic API",
        "status": "running"
    }


@app.get("/services")
def get_services():
    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT service_id, service_name, price, duration_minutes
                FROM services
                WHERE service_status = 'active'
                ORDER BY service_id
                """
            )

            services = cursor.fetchall()
            return services

    finally:
        connection.close()



@app.get("/doctors")
def get_doctors():
    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT
                    d.doctor_id,
                    u.full_name,
                    d.specialty,
                    d.years_of_experience
                FROM doctors AS d
                JOIN staff AS s
                    ON d.staff_id = s.staff_id
                JOIN users AS u
                    ON s.user_id = u.user_id
                ORDER BY d.doctor_id
                """
            )

            doctors = cursor.fetchall()
            return doctors

    finally:
        connection.close()


@app.get("/appointments")
def get_appointments():
    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT
                    appointment_id,
                    doctor_id,
                    service_id,
                    appointment_date,
                    TIME_FORMAT(start_time, '%H:%i') AS start_time,
                    TIME_FORMAT(end_time, '%H:%i') AS end_time,
                    appointment_status
                FROM appointments
                ORDER BY appointment_date, start_time
                LIMIT 50
                """
            )

            appointments = cursor.fetchall()
            return appointments

    finally:
        connection.close()