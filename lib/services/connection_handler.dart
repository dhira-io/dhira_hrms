import 'dart:convert';
import 'dart:io';
import 'package:dhira_hrms/model/Response.dart';
import 'package:dhira_hrms/services/api_service.dart';
import 'package:dhira_hrms/services/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'http_requestTypes.dart';

class ConnectionHandler {
  ConnectionHandler._privateConstructor();
  static final ConnectionHandler singleton =
  ConnectionHandler._privateConstructor();

  //Auth request
  Future<dynamic> makeAuthRequest(
      String requestUrl, HttpRequestType requestType,
      {params, String? baseURl, bool isReturnError = false}) async {
    print('params == $params');

    // var token =
    //     locator<UserDetailsBloc>().getToken() ?? StorageUtil.getString('token');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var gettoken = prefs.getString("token") ?? "";
    var token = gettoken;

   // print("token Bearer== $token");

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'Authorization': 'Bearer $token'
    };
    // print('headers == $headers');

    switch (requestType) {
      case HttpRequestType.GET:
        return await makeGetRequests(requestUrl, headers, params,
            baseURl: baseURl, isReturnError: isReturnError);

      case HttpRequestType.POST:
        return await makePostRequest(requestUrl, headers, params,
            baseURl: baseURl);
      default:
        break;
    }
  }

  //Data Request
  Future<dynamic> makeDataRequest(
      String requestUrl, HttpRequestType requestType,
      {dynamic params, String? baseURl}) async {
    String authToken = 'test'; //Fetch and save the auth token from the server

    if (authToken == '') {
      throw AuthenticationException('Unauthorized');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //var token = locator<UserDetailsBloc>().getToken() ?? globals.token;
    var token = prefs.getString('token') ?? "";

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      //'Authorization': 'Bearer $token'
    };

    switch (requestType) {
      case HttpRequestType.GET:
        return await makeGetRequests(requestUrl, headers, params,
            baseURl: baseURl);
      case HttpRequestType.POST:
        return await makePostRequest(requestUrl, headers, params,
            baseURl: baseURl);
      default:
        break;
    }
  }

  //Request types
//GET request
  Future<dynamic> makeGetRequests(
      String url, Map<String, String> header, Map<String, String>? params,
      {String? baseURl, bool? isReturnError}) async {
    print("makeGetRequests params = $params");

    var responseJson;
    var requestUrl =
        (baseURl == null || baseURl == "" ? ApiService.baseUrl : baseURl) +
            url +
            ((params != null) ? queryParameters(params) : "");
    // var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    print("requesturl == $requestUrl");
    try {
      final response = await http.get(Uri.parse(requestUrl), headers: header);
      print('##Response: ${response.body.toString()}');
      responseJson = returnResponse(response, isReturnError: isReturnError);
      // print(responseJson);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

//Post request
  Future<dynamic> makePostRequest(
      String requestUrl, Map<String, String> header, dynamic body,
      {String? baseURl}) async {
    var responseJson;
    var headers = header;
    var url =
        (baseURl == null || baseURl == "" ? ApiService.baseUrl : baseURl) +
            requestUrl; //uncomment when base urls are same

    try {
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body, encoding: Encoding.getByName('utf-8'),);
      print('base_url => $url');
      print('headers => $headers');

      print("response body ==> ${response.body}");
      var respheader = response.headers;
      var rescookies = respheader['set-cookie'];


      print("response set cookiess ==> $rescookies");

      responseJson = returnResponse(response);
      print(json == "$responseJson");
    } on SocketException {
      print('error');
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

//convert query params
  String queryParameters(Map<String, String> params) {
    final jsonString = Uri(queryParameters: params);
    return '?${jsonString.query}';
  }

  String queryParametersint(Map<String, int> params) {
    print("queryparam = $params");
    print(Uri(queryParameters: params));
    final jsonString = Uri(queryParameters: params);
    print(jsonString);
    return '?${jsonString.query}';
  }

  //Response handling
  dynamic returnResponse(http.Response response, {bool? isReturnError}) {
    var responseJson = json.decode(response.body.toString());
    var responseCookies = json.decode(response.headers.toString());

    print("resp cookies == $responseCookies");
    if (isReturnError == true) {
      return responseJson;
    }
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        return responseJson;
    //throw BadRequestException(Response.fromJson(responseJson).message);
      case 401:
        break;
      case 403:
        throw UnauthorizedException(Response.fromJson(responseJson).message);
      case 500:
        break;
      default:
        throw FetchDataException(Response.fromJson(responseJson).message);
    }
  }
}