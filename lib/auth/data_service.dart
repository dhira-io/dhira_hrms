import 'package:dhira_hrms/model/login_model.dart';

abstract class DataService {

  Future<LoginModel> userLoginApi(Map<String, dynamic> body);


}