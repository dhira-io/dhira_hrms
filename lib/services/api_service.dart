import 'dart:convert';
import 'package:dhira_hrms/model/singleLeave_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:dhira_hrms/model/attendance_model.dart';
import 'package:dhira_hrms/model/empDetails_model.dart';
import 'package:dhira_hrms/model/leave_list_model.dart';
import 'package:dhira_hrms/model/leave_type_model.dart';
import 'package:dhira_hrms/model/organization_emp_model.dart';
import 'package:dhira_hrms/model/projectname_model.dart';
import 'package:dhira_hrms/model/singleTimesheet_model.dart';
import 'package:dhira_hrms/model/timesheet_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/alert_dialogbox.dart';


class ApiService {
  // static const String baseUrl = "https://hardik-dev.akashic.dhira.io/"; //"https://hrms.do.dhira.io/";
  // static const String devbaseUrl = "https://dev-hrms.akashic.dhira.io/";
  static const String baseUrl = "https://dev-hrms.akashic.dhira.io/";

  static const String loginEndpoint = "api/method/login";
  static const String logoutEndpoint = "api/method/logout";
  static const String msloginEndpoint = "api/method/dhira_hrms.api.office365_login.initiate_office365_login";
  static const String msexchangeTokenEndpoint = "api/method/dhira_hrms.api.office365_login.exchange_token_for_session";
  static const String getloggedinuserinfo = "api/method/frappe.auth.get_logged_user";
  static const String forgotpwdEndpoint = "api/method/frappe.core.doctype.user.user.reset_password";
  static const String changepwdEndpoint = "api/method/dhira_hrms.api.auth.change_user_password";

  static const String getEmpInfoEndpoint = "api/resource/Employee";
  static const String getProfileEndpoint = "api/resource/User";
  static const String editProfileEndpoint = "api/method/upload_file";
  static const String checkinstatusEndpoint = "api/method/dhira_hrms.api.navbar.get_checkin_status";
  static const String last5attendEndpoint = "api/method/dhira_hrms.api.navbar.get_last_5_days_attendance";
  static const String calendarEventEndpoint = "api/method/hrms.api.get_attendance_calendar_events";
  static const String punchInEndpoint = "api/method/dhira_hrms.api.navbar.punch_in";
  static const String punchOutEndpoint = "api/method/dhira_hrms.api.navbar.punch_out";
  static const String orgChartEndpoint = "api/method/dhira_hrms.api.organization_chart.get_employee_organization_tree_flat";
  static const String applyLeaveEndpoint = "api/method/dhira_hrms.api.leave_application.create_leave_application";
  static const String getLeaveTypeEndpoint = "api/resource/Leave%20Type";
  static const String getLeaveListEndpoint = "api/resource/Leave%20Application";
  static const String getsingleLeaveEndpoint = "api/resource/Leave%20Application";
  static const String leaveApproveRejEndpoint = "api/method/dhira_hrms.api.leave_application.update_leave_application_status";
  static const String updateLeaveEndpoint = "api/resource/Leave%20Application";
  static const String deleteLeaveEndpoint = "api/resource/Leave%20Application";
  static const String cancelLeaveEndpoint = "api/method/frappe.desk.form.save.cancel";
  static const String getLeaveBalanceEndpoint = "api/method/hrms.hr.doctype.leave_application.leave_application.get_leave_details";
  static const String gettimesheetListEndpoint = "api/resource/Employee%20Timesheet";
  static const String getsingletimesheetEndpoint = "api/resource/Employee%20Timesheet";
  static const String createtimesheetEndpoint = "api/method/dhira_hrms.api.employee_timesheet.create_employee_timesheet";
  static const String updatetimesheetEndpoint = "api/method/dhira_hrms.api.employee_timesheet.update_employee_timesheet";
  static const String ProjectNameEndpoint = "api/resource/Project";
  static const String getuserforApproverEndpoint = "api/method/dhira_hrms.api.employee_timesheet.get_user_by_employee";

  // Login API
  static Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl$loginEndpoint"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "usr": email,
        "pwd": password,
      },
    );

    print("login statuscode == ${response.statusCode}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract cookies
      String? rawCookie = response.headers["set-cookie"];
      if (rawCookie != null) {
        List<String> cookies = rawCookie.split(',');
        Map<String, String> cookieMap = {};
        for (String cookie in cookies) {
          var cookieParts = cookie.split(';')[0].split('=');
          if (cookieParts.length == 2) {
            cookieMap[cookieParts[0].trim()] = cookieParts[1].trim();
          }
        }
        print("cookie ==> $cookieMap");
        await _saveCookies(cookieMap);
      }

      return responseData;
    }
    else if(response.statusCode == 401) {
      var resp = json.decode(response.body);
      String msg = resp['message'];
      throw Exception(msg);
    }
    else {
      print("login failed == ${response.body}");
      throw Exception("Failed to login");
    }
  }

  // Save cookies to SharedPreferences
  static Future<void> _saveCookies(Map<String, String> cookies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cookies", json.encode(cookies));
  }

  // Get saved cookies as header
  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries
          .map((e) => "${e.key}=${e.value}")
          .join("; ");

      prefs.setString('cookieHeader', cookieHeader);

      return {
        "cookie": cookieHeader,
        "Content-Type": "application/x-www-form-urlencoded",
      };
    }
    return {"Content-Type": "application/x-www-form-urlencoded"};
  }

  // Example: Authenticated API call
  static Future<dynamic> getProfile() async {
    final headers = await getHeaders();
    final response = await http.get(
      Uri.parse("$baseUrl$getloggedinuserinfo"),
      headers: headers,
    );
    return json.decode(response.body);
  }

  //logout
  static Future<bool> logout() async {
    final url = Uri.parse("$baseUrl$logoutEndpoint");
    final headers = await ApiService.getHeaders(); // with cookies

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Check if logout was successful (API returns message or status)
        print("Logout response: $data");
        return true;
      } else {
        print("Logout failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Logout error: $e");
      return false;
    }
  }

//Org chat Api
  static Future<OrganizationEmpModel> fetchOrgChart() async {
    final headers = await ApiService.getHeaders(); // with cookies
    final response = await http.get(
      Uri.parse("$baseUrl$orgChartEndpoint"),
      headers: headers,
    );
    print("Org chart statuscode = ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      print("Org chart resp = $jsonData");
      return OrganizationEmpModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load organization chart");
    }
  }

//get emp
  static Future<getemp_detailsModel> getEmpbyUser(String userId) async {
    final filters = jsonEncode([
      ["user_id", "=", userId]
    ]);
    final fields = jsonEncode(["name", "employee_name", "custom_organization_department","leave_approver"]);

    final uri = Uri.parse(baseUrl + getEmpInfoEndpoint).replace(
      queryParameters: {
        "filters": filters,
        "fields": fields,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader =
      cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.get(uri, headers: headers);
    print("GET emp $uri");
    print("headers = $headers");

    print("Status code = ${response.statusCode}");
    print("Status body = ${response.body}");
    //print("Response body (first 500 chars) = ${response.body.length > 500 ? response.body.substring(0, 500) : response.body}");

    if (response.statusCode == 200) {
      // Try to decode as JSON
      //try {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return getemp_detailsModel.fromJson(jsonData);
      // } catch (e) {
      //   print("JSON decode error: $e");
      //   throw Exception("Response was not JSON");
      // }
    } else {
      throw Exception("Failed to load employee: ${response.statusCode}");
    }
  }

  //get checkin status
  static Future<Map<String, dynamic>?> fetchCheckinStatus(empid) async {

    final Uri uri = Uri.parse(
        ApiService.baseUrl + ApiService.checkinstatusEndpoint).replace(
        queryParameters: {
          'employee': empid,
        });

    // Prepare headers
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader =
      cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
      // print("Cookie header = $cookieHeader");
    }

    // print("checkin status uri == $uri\n header = $headers");

    //try {
    final http.Response response = await http.get(uri, headers: headers);

    // Check HTTP status
    if (response.statusCode == 200) {
      // Parse JSON response
      final Map<String, dynamic> data = json.decode(response.body);
      print('checkinstatus Response: $data');
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('checkinstatus body: ${response.body}');
      return null;
    }
    // } catch (e) {
    //   print('Error making GET request: $e');
    //return null;
    // }
  }

  /// Fetch logs (last 5 days)
  static Future<List<LogEntry>?> fetchLogsList(String empid) async {

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader =
      cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
      print("Cookie header = $cookieHeader");
    }

    final body = json.encode({
      'employee': empid,
    });

    final uri = Uri.parse(baseUrl + last5attendEndpoint);
    //try {
    final result = await http.post(uri, headers: headers, body: body);

    // print("Attend logs uri == $uri\n header = $headers \n body =$body");

    if(result.statusCode == 200) {
      final Map<String, dynamic> logsmap = json.decode(result.body);

      // Depending on your API response structure:
      if (logsmap.containsKey('message') &&
          logsmap['message'] is Map<String, dynamic> &&
          logsmap['message']['data'] is List) {
        final List<dynamic> dataList = logsmap['message']['data'];

        return dataList
            .map((e) => LogEntry.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        print("Invalid structure in logs response: $logsmap");
        return null;
      }
    }
    else {
      print("Error logs = ${result.statusCode}");
      return null;
    }
  }

  /// Fetch attendance calendar events via POST
  static Future<Map<String, dynamic>?> fetchAttendanceCalendar({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader =
      cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
      print("Cookie header = $cookieHeader");
    }

    final body = json.encode({
      'employee': employee,
      'from_date': fromDate,
      'to_date': toDate,
    });

    final uri = Uri.parse(baseUrl + calendarEventEndpoint);
    //try {
    final response =
    await http.post(uri, headers: headers, body: body);

    // print("Attend calendarevent uri == $uri\n header = $headers \n body =$body");
    print("Attend calendarevent resp == ${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      print("POST calendarevent failed: ${response.statusCode}, body: ${response
          .body}");
      return null;
    }
    // } catch (e) {
    //   print("Exception in POST $endpoint: $e");
    //   return null;
    // }
  }

  //punch_in
  static Future<Map<String, dynamic>?> punchInAPI(String employee) async {
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final body = json.encode({
      "employee": employee,
    });

    final uri = Uri.parse(baseUrl + punchInEndpoint);
    final response = await http.post(uri, headers: headers, body: body);

    // print("PunchIn request uri: $uri, body: $body, headers: $headers");
    print("PunchIn response: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      print("PunchIn failed: ${response.statusCode} ${response.body}");
      return null;
    }
  }

//punchout
  static Future<Map<String, dynamic>?> punchOutAPI(String employee) async {
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final body = json.encode({
      "employee": employee,
    });

    final uri = Uri.parse(baseUrl + punchOutEndpoint);
    final response = await http.post(uri, headers: headers, body: body);

    print("PunchOut response: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      print("PunchOut failed: ${response.statusCode} ${response.body}");
      return null;
    }
  }

//Create Leave submit

  Future<http.Response> submitLeaveApplication({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,

    // optionally: required String cookieHeader, etc
  }) async {
    final url = Uri.parse(baseUrl + applyLeaveEndpoint);

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final bodyMap = {
      "employee": employeeId,
      "leave_type": leaveType,
      "from_date": fromDate,
      "to_date": toDate,
      "reason": reason,
      "half_day": halfDay,
    };

    print("leave url = $url");
    print("leave bodyMap = $bodyMap");
    print("leave header = $headers");

    if (halfDay == 1 && halfDayDate != null && halfDayDate.isNotEmpty) {
      bodyMap["half_day_date"] = halfDayDate;
    }
    final body = jsonEncode(bodyMap);


    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print("apply leav = ${response.statusCode}\napply leav = ${response.body}");
    return response;
  }

  //update leave
  Future<http.Response> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    final url = Uri.parse('$baseUrl$updateLeaveEndpoint/$leaveId');

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final Map<String, dynamic> body = {
      "from_date":   fromDate,
      "to_date":     toDate,
      "reason":      reason,
      "half_day":    halfDay,
      "half_day_date": halfDayDate,
    };

    // remove half_day_date if null
    if (halfDay == 0) {
      body.remove("half_day_date");
    }

    print("update leav url = $url");
    print("update leav param = $body");

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print("update leav rep = ${response.body}");

    return response;
  }


  //Leave Type
  Future<List<LeaveTypeItemModel>> fetchLeaveTypes() async {
    final uri = Uri.parse(
        '$baseUrl$getLeaveTypeEndpoint?fields=["name","leave_type_name"]'
    );
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List data = json['data'] ?? [];
      return data.map((e) =>
          LeaveTypeItemModel(
            name: e['name'] as String,
            leaveTypeName: e['leave_type_name'] as String,
          )
      ).toList();
    } else {
      throw Exception('Failed to load leave types: ${response.statusCode}');
    }
  }

//leave list
  Future<List<LeaveListModel>> fetchLeaveApplicationsList(
      {int start = 0, int length = 5}) async {

    final uri = Uri.parse('$baseUrl$getLeaveListEndpoint'
        '?fields=["name","employee","employee_name","leave_type","from_date","to_date","status","leave_approver","docstatus","leave_approver_name","total_leave_days"]&limit_start=$start&limit_page_length=$length');

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.get(uri, headers: headers);

    print("leave list ==$uri\nheaders=$headers");
    print("leave list resp ==${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResp = jsonDecode(response.body);
      final List data = jsonResp['data'] as List;
      return data.map((e) => LeaveListModel.fromJson(e)).toList();
    } else {
      throw Exception(
          'Failed to load leave applications: ${response.statusCode}');
    }
  }

  //particular leave
  static Future<singleLeaveModel?> fetchSingleLeave(String leaveId) async {

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final uri = Uri.parse('$baseUrl$getsingleLeaveEndpoint/$leaveId');
    final response = await http.get(uri, headers: headers);

    print("single leave ==> $uri \nsingle leave body => ${response.body}");
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return singleLeaveModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load leave');
    }
  }

  //leave approve/reject
  static Future<bool> updateLeaveApplicationStatus({
    required String leaveApplicationName,
    required String newStatus,
  }) async {
    final String url = baseUrl+leaveApproveRejEndpoint;

    final Map<String, dynamic> body = {
      'leave_application_name': leaveApplicationName,
      'new_status': newStatus,
    };

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    // For debugging
    print('approve/rej lev $url\n param = $body');
    print('approve/rej lev POST → status ${response.statusCode} body ${response.body}');

    if (response.statusCode == 200) {
      // You may need to parse the response and check for some "success": true property
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;

      // Example: you might check something like data['message']['success'] == true
      // Adjust according to your actual response schema
      if (data['message'] != null && data['message']['success'] == true) {
        return true;
      } else {
        // Could throw or return false
        return false;
      }
    } else {
      // Error handling
      return false;
    }
  }

//delete leave
  Future<void> deleteLeaveApplication(String name) async {
    final uri = Uri.parse('$baseUrl$deleteLeaveEndpoint/$name');

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.delete(uri, headers: headers);

    print("DELETE leave application == $uri\nheaders=$headers");
    print("DELETE resp == ${response.body}");

    if (response.statusCode == 200) {
      // Usually response body: {"message": "ok"} per docs. :contentReference[oaicite:4]{index=4}
      return;
    } else {
      throw Exception('Failed to delete leave application: ${response.statusCode}, body: ${response.body}');
    }
  }

  //cancel leave
  Future<void> cancelLeaveApplication(String name) async {
    final uri = Uri.parse('$baseUrl$cancelLeaveEndpoint');

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final body = json.encode({
      "doctype": "Leave Application",
      "name": name
    });

    final response = await http.post(uri, headers: headers, body: body);

    print("CANCEL leave application == $uri\nheaders=$headers\nbody=$body");
    print("CANCEL resp == ${response.body}");

    if (response.statusCode == 200) {
      // check response format (maybe includes "message" or "docs" etc)
      return;
    } else {
      throw Exception('Failed to cancel leave application: ${response.statusCode}, body: ${response.body}');
    }
  }

  //get leave balance
  Future<Map<String, dynamic>> getLeaveBalance(employeeID, todaydate) async {
    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept":"application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["Cookie"] = cookieHeader;
    }

    final uri = Uri.parse('$baseUrl$getLeaveBalanceEndpoint');

    // final body = formData.entries.map((e) => "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}").join("&");
     final body = "employee=$employeeID&date=$todaydate";
    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    print("balance uri=$uri\nparam=$body\nresp =${response.body}");
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return decoded;
    } else {
      throw Exception('API POST failed: ${response.statusCode} ${response.body}');
    }
  }

  //timesheet list
  static Future<List<TimesheetListModel>> fetchTimesheets({int start = 0, int limit = 5,}) async {
    final queryParameters = {
      'fields': jsonEncode([
        "name",
        "employee","employee_name",
        "hours_total",
        "from_date",
        "to_date",
        "docstatus",
        "expected_hours_total",
        "remaining_hours",
        "total_spent_hours",
        "approver","approver_name"
      ]),
      'limit_start': start.toString(),
      'limit_page_length': limit.toString(),
    };

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final uri = Uri.parse(baseUrl+gettimesheetListEndpoint).replace(queryParameters: queryParameters);

    print("timesheet list url =$uri");
    final response = await http.get(uri, headers: headers);

    print("timesheet headers =$headers");
    print("timesheet list resp =${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> resplist = data['data'];
      var approver = resplist[0]['approver'];
      prefs.setString('approver', approver);
      return resplist.map((e) => TimesheetListModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load timesheets: ${response.statusCode}');
    }
  }

  //particular timesheet
  static Future<singleTimesheetModel?> fetchSingleTimesheets(String timesheetId) async {

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final uri = Uri.parse('$baseUrl$getsingletimesheetEndpoint/$timesheetId');
    final response = await http.get(uri, headers: headers);

    print("single timesheet ==> $uri \nsingle timesheet body => ${response.body}");
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return singleTimesheetModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load timesheets');
    }
  }

  //submit timesheet
  static Future<bool> createTimesheet(context, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl+createtimesheetEndpoint);

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("create timesheet resp = ${response.statusCode}\n${response.body}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded["message"]["success"] == true) {
        // success
        return response.statusCode == 200;
      } else {
        String errorMessage = "Unknown error";

        // 1️⃣ Extract from _server_messages (most accurate, user-facing)
        if (decoded["_server_messages"] != null) {
          try {
            List<dynamic> serverMessages = json.decode(decoded["_server_messages"]);
            if (serverMessages.isNotEmpty) {
              Map<String, dynamic> msgObj = json.decode(serverMessages.first);
              errorMessage = msgObj["message"] ?? errorMessage;

              // Remove HTML tags like <strong>
              errorMessage = errorMessage.replaceAll(RegExp(r"<[^>]*>"), "");
            }
          } catch (e) {
            print("Failed to parse _server_messages: $e");
          }
        }

        // 2️⃣ Fallback to message.error
        if (errorMessage == "Unknown error" && decoded["message"]?["error"] != null) {
          errorMessage = decoded["message"]["error"]
              .toString()
              .replaceAll(RegExp(r"<[^>]*>"), "");
        }

        // 3️⃣ Final fallback
        if (errorMessage.trim().isEmpty) {
          errorMessage = "Unknown error occurred";
        } errorMessage = "Unknown error";

        // 1️⃣ Extract from _server_messages (most accurate, user-facing)
        if (decoded["_server_messages"] != null) {
          try {
            List<dynamic> serverMessages = json.decode(decoded["_server_messages"]);
            if (serverMessages.isNotEmpty) {
              Map<String, dynamic> msgObj = json.decode(serverMessages.first);
              errorMessage = msgObj["message"] ?? errorMessage;

              // Remove HTML tags like <strong>
              errorMessage = errorMessage.replaceAll(RegExp(r"<[^>]*>"), "");
            }
          } catch (e) {
            print("Failed to parse _server_messages: $e");
          }
        }

        // 2️⃣ Fallback to message.error
        if (errorMessage == "Unknown error" && decoded["message"]?["error"] != null) {
          errorMessage = decoded["message"]["error"]
              .toString()
              .replaceAll(RegExp(r"<[^>]*>"), "");
        }

        // 3️⃣ Final fallback
        if (errorMessage.trim().isEmpty) {
          errorMessage = "Unknown error occurred";
        }

        ShowAlertdialogue(context, errorMessage);
        throw Exception(errorMessage);
      }
    } else {
      throw Exception("Failed to submit timesheet: ${response.statusCode}");
    }
  }

  //update timesheet
  static Future<bool> updateTimesheet(context, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl+updatetimesheetEndpoint);

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("update timesheet resp = ${response.statusCode}\n${response.body}");
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded["message"]["success"] == true) {
        // success
        return response.statusCode == 200;
      } else {
        String errorMessage = "Unknown error";

        // 1️⃣ Extract from _server_messages (most accurate, user-facing)
        if (decoded["_server_messages"] != null) {
          try {
            List<dynamic> serverMessages = json.decode(decoded["_server_messages"]);
            if (serverMessages.isNotEmpty) {
              Map<String, dynamic> msgObj = json.decode(serverMessages.first);
              errorMessage = msgObj["message"] ?? errorMessage;

              // Remove HTML tags like <strong>
              errorMessage = errorMessage.replaceAll(RegExp(r"<[^>]*>"), "");
            }
          } catch (e) {
            print("Failed to parse _server_messages: $e");
          }
        }

        // 2️⃣ Fallback to message.error
        if (errorMessage == "Unknown error" && decoded["message"]?["error"] != null) {
          errorMessage = decoded["message"]["error"]
              .toString()
              .replaceAll(RegExp(r"<[^>]*>"), "");
        }

        // 3️⃣ Final fallback
        if (errorMessage.trim().isEmpty) {
          errorMessage = "Unknown error occurred";
        } errorMessage = "Unknown error";

        // 1️⃣ Extract from _server_messages (most accurate, user-facing)
        if (decoded["_server_messages"] != null) {
          try {
            List<dynamic> serverMessages = json.decode(decoded["_server_messages"]);
            if (serverMessages.isNotEmpty) {
              Map<String, dynamic> msgObj = json.decode(serverMessages.first);
              errorMessage = msgObj["message"] ?? errorMessage;

              // Remove HTML tags like <strong>
              errorMessage = errorMessage.replaceAll(RegExp(r"<[^>]*>"), "");
            }
          } catch (e) {
            print("Failed to parse _server_messages: $e");
          }
        }

        // 2️⃣ Fallback to message.error
        if (errorMessage == "Unknown error" && decoded["message"]?["error"] != null) {
          errorMessage = decoded["message"]["error"]
              .toString()
              .replaceAll(RegExp(r"<[^>]*>"), "");
        }

        // 3️⃣ Final fallback
        if (errorMessage.trim().isEmpty) {
          errorMessage = "Unknown error occurred";
        }
        ShowAlertdialogue(context, errorMessage);

        throw Exception(errorMessage);
      }
    } else {
      throw Exception("Failed to update timesheet: ${response.statusCode}");
    }
  }

  //get project names
  static Future<List<ProjectNameModel>> fetchProjects() async {
    final url = Uri.parse(
        '$baseUrl$ProjectNameEndpoint?fields=["name","project_name","status","expected_start_date","expected_end_date"]');

    final prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString("cookies");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (cookieString != null) {
      Map<String, dynamic> cookieMap = json.decode(cookieString);
      String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
      headers["cookie"] = cookieHeader;
    }

    final response = await http.get(url, headers: headers);
    print("fetchProjects ==> ${response.statusCode}\n ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse["data"];
      return data.map((e) => ProjectNameModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load projects (Code: ${response.statusCode})');
    }
  }

  //get timesheet approver
  static Future<Map<String, dynamic>?> getUserForApprover(String employeeId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? cookieString = prefs.getString("cookies");

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (cookieString != null) {
        Map<String, dynamic> cookieMap = json.decode(cookieString);
        String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
        headers["cookie"] = cookieHeader;
      }

      final url = Uri.parse(
        "$baseUrl$getuserforApproverEndpoint?employee=$employeeId",
      );

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  //get profile
  Future<Map<String, dynamic>> fetchProfileData(useremail) async {
    final String _fieldsParam = '["username","desk_theme"]';
    try {
      // 1. Construct the URL with query parameters
      final Uri url = Uri.parse('$baseUrl$getProfileEndpoint/$useremail')
          .replace(queryParameters: {'fields': _fieldsParam});

      final prefs = await SharedPreferences.getInstance();
      String? cookieString = prefs.getString("cookies");

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (cookieString != null) {
        Map<String, dynamic> cookieMap = json.decode(cookieString);
        String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
        headers["cookie"] = cookieHeader;
      }

      // 3. Make the GET request
      final response = await http.get(url, headers: headers);

      print("profile url = $url\nstatuscode=${response.statusCode}");
      print("profile resp = ${response.body}");

      if (response.statusCode == 200) {
        // Return the decoded JSON body (which contains the 'data' map)
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // Throw a custom error for non-200 status codes
        throw Exception('API failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw a generic error for network or decoding failures
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  //edit profile
  Future<bool> uploadProfileImage(String filePath, String userEmail) async {
    final uploadUrl = Uri.parse('$baseUrl$editProfileEndpoint');

    try {
      var request = http.MultipartRequest('PUT', uploadUrl);

      final prefs = await SharedPreferences.getInstance();
      String? cookieString = prefs.getString("cookies");

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (cookieString != null) {
        Map<String, dynamic> cookieMap = json.decode(cookieString);
        String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
        headers["cookie"] = cookieHeader;
      }

      request.headers.addAll(headers);

      // Form-data fields
      request.fields['doctype'] = 'User';
      request.fields['docname'] = userEmail;
      request.fields['fieldname'] = 'user_image';
      request.fields['folder'] = 'Home';
      request.fields['is_private'] = '0';

      // File attachment
      final fileName = path.basename(filePath);
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        filePath,
        filename: fileName,
      );
      request.files.add(multipartFile);

      print("upload img params =${request.fields},${request.files}");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("upload img resp =${response.body}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        throw Exception('Image upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image upload exception: $e');
    }
  }

  //forgot password
  Future<String> forgotPasswordResetEmail(String userEmail) async {
    final Uri url = Uri.parse(baseUrl);

    final Map<String, String> body = {
      'cmd': 'frappe.core.doctype.user.user.reset_password',
      'user': userEmail,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final response = await http.post(url, headers: headers, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // 1. decode outer JSON
      final Map<String, dynamic> outer = jsonDecode(response.body) as Map<String, dynamic>;

      // 2. If API sends message directly
      if (outer.containsKey('message')) {
        return outer['message'] as String;
      }

      // 3. Else, if API uses nested _server_messages format
      if (outer.containsKey('_server_messages')) {
        final String serverMessagesString = outer['_server_messages'] as String;
        // decode that string → should be a List<dynamic>
        final List<dynamic> list = jsonDecode(serverMessagesString) as List<dynamic>;
        if (list.isNotEmpty) {
          final String innerJson = list[0] as String;
          final Map<String, dynamic> obj = jsonDecode(innerJson) as Map<String, dynamic>;
          if (obj.containsKey('message')) {
            return obj['message'] as String;
          }
        }
      }

      throw Exception('Unexpected response format: no message found');
    } else {
      try {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        if (errorBody.containsKey('message')) {
          throw Exception(errorBody['message']);
        }
      } catch (_) {}
      throw Exception('Server error: status code ${response.statusCode}');
    }
  }

  //change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // 1. Prepare the request body as a map
      final Map<String, String> body = {
        'current_password': currentPassword,
        'new_password': newPassword,
      };
      final prefs = await SharedPreferences.getInstance();
      String? cookieString = prefs.getString("cookies");

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };
      if (cookieString != null) {
        Map<String, dynamic> cookieMap = json.decode(cookieString);
        String cookieHeader = cookieMap.entries.map((e) => "${e.key}=${e.value}").join("; ");
        headers["cookie"] = cookieHeader;
      }

      // 3. Make the POST request. http.post automatically handles encoding the body
      // when Content-Type is set to application/x-www-form-urlencoded.
      final response = await http.post(
        Uri.parse(baseUrl+changepwdEndpoint),
        headers: headers,
        body: body,
      );

      print("change pwd = ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Check for success message specific to your API
        if (jsonResponse.containsKey('message') && jsonResponse['message'] is String) {
          // Assuming success is indicated by a specific message or lack of error key
          if (jsonResponse['message'].toString().toLowerCase().contains('password changed')) {
            return; // Success
          }
        }

        // If 200 but API indicates a logical error inside the body
        if (jsonResponse.containsKey('exc')) {
          throw Exception(jsonResponse['exc']);
        }

        return; // Assume success if no specific error is found in a 200 response

      } else {
        // Handle non-200 status codes (e.g., 401 Unauthorized, 403 Forbidden)
        String error = 'Server Error (Status ${response.statusCode})';
        try {
          final errorBody = jsonDecode(response.body);
          if (errorBody.containsKey('message')) {
            error = errorBody['message'];
          }
        } catch (_) {
          // Ignore decoding errors if the response is not JSON
        }
        throw Exception(error);
      }
    } on Exception catch (e) {
      throw Exception('Password change failed: ${e.toString()}');
    }
  }


  // ----------- Example Function --------------
/*  static Future<Map<String, dynamic>> exchangeToken({
    required String apiKey,
    required String apiSecret,
  }) async {
    final url =
        "$devbaseUrl/api/method/dhira_hrms.api.office365_login.exchange_token_for_session";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "api_key": apiKey,
        "api_secret": apiSecret,
      }),
    );

    return jsonDecode(response.body);
  }*/

}