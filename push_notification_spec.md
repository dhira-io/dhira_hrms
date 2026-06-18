# DHIRA Push Notification — Flutter Integration Spec

**Version:** 1.0 | **Date:** May 2026 | **Audience:** Flutter / Mobile Team

---

## 1. How It Works (Server Side — Brief)

1. A document (Leave Application, Timesheet, etc.) is saved/submitted.
2. Server creates a **DHIRA Notification Log** record.
3. An email is sent immediately.
4. A background job calls Firebase FCM and creates a **Push Log** record per device token.
5. Flutter receives the FCM message.

---

## 2. FCM Message Structure

Every push has two parts: `notification` (shown by OS) and `data` (read by your code).

```
{
  "notification": {
    "title": "<string>",   // shown in the notification tray
    "body":  "<string>"    // shown below the title
  },
  "data": {
    // see Section 3 — all values are STRINGS
  }
}
```

> **FCM rule:** every value inside `data` is a `String`. Never expect int or bool.

---

## 3. Data Payload — Two Types

### 3a. Immediate (single document)

Triggered when one specific document needs attention.

| Key | Type | Example | Notes |
|---|---|---|---|
| `type` | String | `"leave_application"` | snake_case doctype name |
| `reference_doctype` | String | `"Leave Application"` | human-readable doctype |
| `reference_name` | String | `"LA-00012"` | document ID |
| `mobile_url` | String | `"/app/leave-application/LA-00012"` | deep link; may be empty |

**Example:**
```json
{
  "type": "leave_application",
  "reference_doctype": "Leave Application",
  "reference_name": "LA-00012",
  "mobile_url": "/app/leave-application/LA-00012"
}
```

---

### 3b. Digest / Bulk (grouped summary)

Triggered by daily, weekly, or monthly scheduled jobs — groups multiple pending items.

| Key | Type | Example | Notes |
|---|---|---|---|
| `type` | String | `"bulk"` | always `"bulk"` |
| `is_bulk` | String | `"1"` | check this first |
| `count` | String | `"3"` | total items, parse as int |
| `items` | String | `"[{\"label\":\"Leave Application\",\"count\":2},{\"label\":\"Timesheet\",\"count\":1}]"` | JSON string — call `jsonDecode()` |
| `mobile_url` | String | `"/app/notifications"` | open notifications list |

**Example:**
```json
{
  "type": "bulk",
  "is_bulk": "1",
  "count": "3",
  "items": "[{\"label\":\"Leave Application\",\"count\":2},{\"label\":\"Timesheet\",\"count\":1}]",
  "mobile_url": "/app/notifications"
}
```

---

## 4. Flutter Handling Logic

```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  final data = message.data; // Map<String, String>

  if (data['is_bulk'] == '1') {
    // Digest notification
    final int count = int.tryParse(data['count'] ?? '0') ?? 0;
    final List items = jsonDecode(data['items'] ?? '[]');
    // Navigate to notifications list screen
    // data['mobile_url'] → "/app/notifications"

  } else {
    // Immediate notification
    final String doctype = data['reference_doctype'] ?? '';
    final String name    = data['reference_name'] ?? '';
    final String url     = data['mobile_url'] ?? '';
    // Navigate using mobile_url if present, else build route from doctype+name
  }
});
```

---

## 5. Push Log (Server Record)

Every FCM send attempt creates one Push Log row. Useful for debugging.

| Field | Type | Notes |
|---|---|---|
| `user` | Link → User | recipient user id |
| `device_token` | Small Text | FCM token used |
| `title` | Data | notification title sent |
| `status` | Select | `Sent` or `Failed` |
| `error` | Text | error message if failed |
| `notification_log` | Link → DHIRA Notification Log | parent log record |
| `reference_doctype` | Data | e.g. `"Leave Application"` |
| `reference_name` | Data | e.g. `"LA-00012"` |
| `message_id` | Data | Firebase response message ID |
| `sent_at` | Datetime | timestamp of send attempt |

---

## 6. Navigation Decision Tree

```
Receive FCM message
        │
        ├─ data['is_bulk'] == "1"
        │       └─ Open Notifications List screen
        │          (filter by pending approvals)
        │
        └─ Immediate
                │
                ├─ data['mobile_url'] not empty
                │       └─ Navigate to mobile_url directly
                │
                └─ mobile_url empty
                        └─ Build route from reference_doctype + reference_name
```

---

## 7. Edge Cases

| Scenario | What to do |
|---|---|
| `reference_name` is empty on a bulk message | Open notifications list, do not crash |
| `items` JSON fails to parse | Show generic "You have pending approvals" message |
| `mobile_url` starts with `/app/` | Prepend base URL or treat as in-app route |
| Token rejected by FCM | Server auto-disables the device token; user must re-register |

---

## 8. Questions / Contact

Backend contact: hemant.tripathi@dhira.io  
All push logs visible in Frappe desk → **DHIRA Setup → Push Log**
