from database import get_connection

connection = get_connection()

try:
    with connection.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) AS total_services FROM services")

        result = cursor.fetchone()

        print("Database connection successful!")
        print("Total services:", result["total_services"])

finally:
    connection.close()
    