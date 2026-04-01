import 'package:dhira_hrms/model/Response.dart';
import 'package:dhira_hrms/model/login_model.dart';
import 'package:dhira_hrms/services/api_endpoints.dart';
import 'package:dhira_hrms/services/connection_handler.dart';
import 'package:dhira_hrms/services/http_requestTypes.dart';

import 'data_service.dart';

class WebDataService implements DataService {

//Login API
  @override
  Future<LoginModel> userLoginApi(Map<String, dynamic> body) async {
    print("login param =$body");
    final response = await ConnectionHandler.singleton.makeAuthRequest(
        APIEndPointHelper.getValue(APIEndPoint.login), HttpRequestType.POST,
        params: body);
        //params: json.encode(body));
    print('login response = $response');
    return LoginModel.fromJson(response);
  }

  //Logout API
  Future<Response> logout(context) async {

    final response = await ConnectionHandler.singleton.makeAuthRequest(
        APIEndPointHelper.getValue(APIEndPoint.logout),
        HttpRequestType.GET,
    );
    print('logout response =$response');
    return Response.fromJson(response);
  }
}
