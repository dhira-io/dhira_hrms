# DHIRA HRMS — API Reference for Flutter

## Base URL
```
Production: https://<your-frappe-site>
Dev proxy:  /api  (React only)
```

## Auth
All requests require session cookie **or** token header:
```
Authorization: token <api_key>:<api_secret>
```

---

## Notification Preferences

### GET preferences
```
GET /api/method/dhira_hrms.api.notifications.get_notification_preferences
```
Auto-creates record with all `1` defaults if first time.

**Response**
```json
{
  "message": {
    "doc_name": "abc123",
    "push_leave_application": 1,
    "push_employee_timesheet": 1,
    "push_compensatory_leave_request": 1,
    "push_attendance_regularization_request": 1,
    "email_leave_application": 1,
    "email_employee_timesheet": 1,
    "email_compensatory_leave_request": 1,
    "email_attendance_regularization_request": 1
  }
}
```

### Toggle a single field
```
POST /api/method/dhira_hrms.api.notifications.update_notification_preference
Content-Type: application/json

{
  "field": "push_leave_application",
  "value": 0
}
```
`value`: `0` = off, `1` = on

**Valid field names**
| Field | Description |
|---|---|
| `push_leave_application` | Push — Leave |
| `push_employee_timesheet` | Push — Timesheet |
| `push_compensatory_leave_request` | Push — Comp Off |
| `push_attendance_regularization_request` | Push — Attendance |
| `email_leave_application` | Email — Leave |
| `email_employee_timesheet` | Email — Timesheet |
| `email_compensatory_leave_request` | Email — Comp Off |
| `email_attendance_regularization_request` | Email — Attendance |

**Response**
```json
{
  "message": {
    "success": true,
    "field": "push_leave_application",
    "value": 0
  }
}
```

---

## Policy Hub

### Get policies (employee view)
Only returns rows with a file attached. Sorted A→Z.
```
GET /api/method/dhira_hrms.api.policy.get_policy_list
```
**Response**
```json
{
  "message": {
    "policies": [
      {
        "id": "abc123xyz",
        "title": "Leave Policy",
        "description": "Covers all leave types...",
        "file_url": "/private/files/Leave_Policy.pdf"
      }
    ],
    "total": 1,
    "available": 1
  }
}
```

### Get file as base64 (to render PDF/DOCX)
```
GET /api/method/dhira_hrms.api.file.get_pdf_file_base64?file_url=/private/files/Leave_Policy.pdf
```
**Response**
```json
{
  "message": {
    "file_name": "Leave_Policy.pdf",
    "file_bytes": "<base64 string>"
  }
}
```
- `file_bytes` is base64 encoded — decode and render as PDF or DOCX
- For DOCX: convert `file_bytes` → bytes → parse with a Word library

---

## Notes
- All responses are wrapped in `message` — always read `response["message"]`
- Session user is resolved server-side — never send `user` or `company` from client
- `file_url` paths are private — never fetch directly, always use the base64 API
