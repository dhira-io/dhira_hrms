enum APIEndPoint {
  login,
  logout,
  getloggedinuserinfo,
}


class APIEndPointHelper {

  static String getValue(APIEndPoint path) {
    switch (path) {
      case APIEndPoint.login:
        return "api/method/login";
      case APIEndPoint.logout:
        return "api/method/logout";
      case APIEndPoint.getloggedinuserinfo:
        return "api/method/frappe.auth.get_logged_user";

    }
  }
}