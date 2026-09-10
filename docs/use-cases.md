# Use Cases

## 1. Actors

The system includes the following actors:

- Patient
- Doctor
- Nurse
- Receptionist
- Employee
- Supervisor
- Manager
- Admin


## 2. Patient Use Cases

The Patient can:

- Register a new account.
- Log in to the system.
- Log out of the system.
- View and update personal profile information.
- View clinic services.
- View available doctors.
- View doctor profiles, including:
  - Doctor name.
  - Specialty.
  - Qualifications.
  - Professional background.
  - Years of experience.
  - Available appointment times.
- Search for doctors.
- View available appointment slots for each doctor.
- Book an appointment.
- Reschedule an appointment.
- Cancel an appointment according to clinic policy.
- View upcoming appointments.
- View previous appointments.
- View appointment details, including:
  - Doctor name.
  - Assigned nurse.
  - Appointment date.
  - Appointment time.
  - Service type.
  - Appointment status.
- View previous visit information permitted for the patient.
- View prescriptions.
- View treatment instructions.
- View follow-up instructions.
- View billing and payment information.
- View clinic offers and promotions.
- Receive appointment confirmation notifications.
- Receive appointment reminder notifications.
- Receive follow-up notifications.
- Receive clinic announcements and offers.
- Use the AI Assistant for permitted clinic-related services.


## 3. Doctor Use Cases

The Doctor can:

- Log in to the system.
- Log out of the system.
- View personal profile.
- Update permitted professional profile information.
- View weekly work schedule.
- View working hours.
- View daily appointments.
- View upcoming appointments.
- View assigned patients.
- View patient appointment details.
- View assigned nurse for each appointment.
- View the service requested by the patient.
- Access authorized patient medical records.
- View patient visit history.
- View previous diagnoses.
- View previous prescriptions.
- View previous treatment plans.
- Start a consultation.
- Record consultation notes.
- Record diagnosis.
- Create a treatment plan.
- Create a prescription.
- Add medication instructions.
- Add treatment instructions.
- Request patient follow-up.
- Determine recommended follow-up date.
- View patient follow-up status.
- Review information entered by nurses.
- View relevant clinical reports.
- View appointment statistics related to the doctor's schedule.


## 4. Nurse Use Cases

The Nurse can:

- Log in to the system.
- Log out of the system.
- View personal profile.
- View weekly work schedule.
- View daily work schedule.
- View working hours for each day.
- View assigned doctor or doctors.
- View appointments assigned to the nurse.
- View patient name for each appointment.
- View appointment time.
- View appointment status.
- View the doctor responsible for each appointment.
- View the service booked by the patient, such as:
  - Laser treatment.
  - Chemical peeling.
  - Skin consultation.
  - Facial treatment.
  - Acne treatment.
  - Follow-up appointment.
  - Other dermatology services.
- View permitted patient information.
- View relevant medical history when authorized.
- Record pre-consultation information.
- Record patient measurements when required.
- Record relevant observations.
- Add nursing notes.
- Prepare the patient before the consultation or procedure.
- Update patient preparation status.
- View doctor instructions related to the patient.
- Record completion of assigned nursing tasks.
- Assist the doctor during selected procedures.
- Update permitted follow-up information.
- View upcoming assigned appointments.
- View completed appointments.
- Receive changes to the work schedule.
- Receive appointment or task notifications.

The Nurse cannot:

- Create or approve a medical diagnosis.
- Create or approve a medical prescription.
- Modify restricted doctor-only clinical information.
- Access administrative or financial information unless specifically authorized.


## 5. Receptionist Use Cases

The Receptionist can:

- Log in to the system.
- Log out of the system.
- View daily appointment schedule.
- View doctor schedules.
- View doctor availability.
- View nurse availability when required.
- Register a new patient.
- Search for an existing patient.
- View basic patient information.
- Update permitted patient contact information.
- Book an appointment for a patient.
- Reschedule an appointment.
- Cancel an appointment according to clinic policy.
- Confirm patient arrival.
- Check in a patient.
- Update appointment status.
- Assign an available appointment slot.
- View clinic services.
- View service prices.
- View clinic offers and promotions.
- Create basic billing records where permitted.
- Record payment status where permitted.
- Print or provide appointment information.
- Send appointment confirmation information.
- Manage waiting list information.
- View daily patient flow.

The Receptionist cannot:

- Add or modify diagnoses.
- Add or modify prescriptions.
- Modify doctor clinical notes.
- Access restricted patient medical information.


## 6. Employee Use Cases

The Employee can:

- Log in to the system.
- Log out of the system.
- View personal profile.
- View assigned work schedule.
- View working hours.
- View assigned tasks.
- Update task status.
- View permitted clinic information.
- Receive internal notifications.
- Perform administrative or operational tasks based on assigned permissions.

Employee permissions depend on the employee's assigned role or department.


## 7. Supervisor Use Cases

The Supervisor can:

- Log in to the system.
- Log out of the system.
- View clinic daily operations.
- View employee schedules.
- View nurse schedules.
- View receptionist schedules.
- View assigned staff.
- Monitor employee attendance or work status.
- View daily appointment flow.
- Monitor appointment delays.
- Monitor waiting patients.
- View operational issues.
- Assign operational tasks.
- Review completed staff tasks.
- Monitor service workflow.
- Review operational reports.
- View selected performance indicators.
- Receive operational alerts.
- Report or escalate issues to the Manager.


## 8. Manager Use Cases

The Manager can:

- Log in to the system.
- Log out of the system.
- View management dashboard.
- View clinic performance statistics.
- View number of appointments.
- View completed appointments.
- View cancelled appointments.
- View no-show appointments.
- View patient statistics.
- View service statistics.
- View most requested services.
- View doctor workload.
- View nurse workload.
- View staff performance information.
- View operational reports.
- View financial reports.
- View revenue information.
- View payment statistics.
- View clinic offers performance.
- View monthly and weekly reports.
- Export selected reports to Excel.
- Export selected clinic data to Excel.
- View Power BI dashboards when integrated.
- Monitor clinic operations.
- Review supervisor reports.
- Support management decision-making using reports and analytics.


## 9. Admin Use Cases

The Admin can:

- Log in to the system.
- Log out of the system.
- Create user accounts.
- Edit user accounts.
- Activate user accounts.
- Deactivate user accounts.
- Assign roles to users.
- Manage permissions.
- Create staff accounts.
- Manage doctor accounts.
- Manage nurse accounts.
- Manage receptionist accounts.
- Manage supervisor accounts.
- Manage manager accounts.
- Manage clinic services.
- Add a new clinic service.
- Edit clinic services.
- Activate or deactivate clinic services.
- Manage service prices.
- Manage clinic offers and promotions.
- Manage system configuration.
- Manage appointment settings.
- Manage working hours.
- Manage doctor schedules.
- Manage nurse schedules.
- Manage staff schedules.
- View system activity.
- View administrative reports.
- Manage API integrations.
- Manage automation integrations.
- Manage n8n integration settings.
- Manage AI Assistant integration settings.
- Manage authorized system access.


## 10. Appointment Management Use Cases

Authorized users can:

- Create an appointment.
- View an appointment.
- Update an appointment.
- Cancel an appointment.
- Reschedule an appointment.
- Confirm an appointment.
- Check in a patient.
- Mark an appointment as completed.
- Mark an appointment as cancelled.
- Mark an appointment as no-show.
- Assign a doctor to an appointment.
- Assign a nurse to an appointment.
- Assign a clinic service to an appointment.
- View appointment history.
- View available appointment slots.


## 11. Clinic Service Use Cases

Authorized users can:

- View clinic services.
- Add new services.
- Edit service information.
- Set service price.
- Set service duration.
- Activate or deactivate services.
- Associate services with doctors.
- Associate services with required staff.
- View service booking statistics.

Examples of clinic services may include:

- Dermatology Consultation
- Laser Treatment
- Chemical Peeling
- Acne Treatment
- Scar Treatment
- Skin Rejuvenation
- Facial Treatment
- Follow-up Consultation


## 12. Medical Record Use Cases

Authorized medical staff can:

- View patient medical records.
- View visit history.
- Create consultation records.
- Record diagnoses.
- Record treatment plans.
- Record prescriptions.
- Add clinical notes.
- Add nursing notes.
- View previous treatments.
- View follow-up information.
- Maintain medical history.


## 13. Billing and Payment Use Cases

Authorized users can:

- Create a billing record.
- View billing records.
- Add services to a bill.
- Calculate total amount.
- Record payment.
- Update payment status.
- View payment history.
- View unpaid bills.
- Generate billing reports.
- Export billing reports to Excel.


## 14. Offers and Promotions Use Cases

Authorized administrative users can:

- Create an offer.
- Edit an offer.
- Define offer start date.
- Define offer end date.
- Define discount value.
- Associate an offer with one or more services.
- Activate an offer.
- Deactivate an offer.
- View offer performance.

Patients can:

- View active offers.
- View offer details.
- View services included in an offer.


## 15. Reports and Analytics Use Cases

Authorized management users can:

- View appointment reports.
- View patient reports.
- View service reports.
- View financial reports.
- View staff workload reports.
- View doctor performance indicators.
- View appointment cancellation statistics.
- View no-show statistics.
- View most requested clinic services.
- Export reports to Excel.
- Export selected database information to Excel.
- Use exported data for further analysis.
- View Power BI dashboards when integrated.


## 16. Notification and Automation Use Cases

The system can:

- Send appointment confirmation notifications.
- Send appointment reminder notifications.
- Send appointment cancellation notifications.
- Send rescheduling notifications.
- Send patient follow-up reminders.
- Send internal staff notifications.
- Send schedule change notifications.
- Trigger automated workflows using n8n.
- Send management alerts based on predefined conditions.


## 17. AI Assistant Use Cases

The AI Assistant can perform approved tasks such as:

- Answer general questions about clinic services.
- Provide clinic working hours.
- Provide information about doctors.
- Provide available appointment information.
- Assist a patient in finding a suitable appointment.
- Assist with appointment booking through authorized APIs.
- Assist with appointment rescheduling through authorized APIs.
- Assist with appointment cancellation through authorized APIs.
- Retrieve permitted patient appointment information.
- Provide permitted information about clinic offers.
- Trigger approved n8n workflows.
- Use approved API tools to interact with the clinic system.

The AI Assistant cannot:

- Directly modify the database.
- Bypass user permissions.
- Access unauthorized patient information.
- Make final medical diagnoses.
- Replace the doctor in clinical decision-making.