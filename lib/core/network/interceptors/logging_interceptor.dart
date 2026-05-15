import 'package:dio/dio.dart';
import '../../utils/secure_logger.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    SecureLogger.i('REQUEST[${options.method}] => PATH: ${options.path}');
    SecureLogger.d('Headers: ${SecureLogger.mask(options.headers)}');
    if (options.queryParameters.isNotEmpty) {
      SecureLogger.d('Query: ${SecureLogger.mask(options.queryParameters)}');
    }
    if (options.data != null) {
      SecureLogger.d('Body', options.data);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    SecureLogger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    SecureLogger.d('Data', response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    SecureLogger.e('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}', 
      error: err.message,
      data: err.response?.data,
    );
    return super.onError(err, handler);
  }
}
