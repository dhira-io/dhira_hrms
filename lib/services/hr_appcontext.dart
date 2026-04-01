import 'package:dhira_hrms/auth/data_service.dart';
import 'package:dhira_hrms/auth/webdata_services.dart';

class HRAppContext {
  HRAppContext._privateConstructor();

  static final HRAppContext shared = HRAppContext._privateConstructor();

  final _webDataService = WebDataService();
  DataService get dataService => _webDataService;

  // final _webService = WebService();
  // AuthService get authService => _webService;
}
