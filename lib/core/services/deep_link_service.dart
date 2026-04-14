import 'package:app_links/app_links.dart';
import '../../features/auth/presentation/bloc/sso_cubit.dart';

class DeepLinkService {
  late final AppLinks _appLinks;
  final SSOCubit _ssoCubit;

  DeepLinkService(this._ssoCubit) {
    _initDeepLinks();
  }

  void _initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle cold start
    final uri = await _appLinks.getInitialLink();
    if (uri != null) _handleIncomingUri(uri);

    // Handle app running in background/foreground
    _appLinks.uriLinkStream.listen((uri) {
      _handleIncomingUri(uri);
    });
  }

  void _handleIncomingUri(Uri uri) {
    if (uri.scheme == "com.dhira.hrms" &&
        uri.host == "auth" &&
        uri.path == "/callback") {
      
      final success = uri.queryParameters["success"];
      final apiKey = uri.queryParameters["api_key"];
      final apiSecret = uri.queryParameters["api_secret"];

      if (success == "true" && apiKey != null && apiSecret != null) {
        _ssoCubit.onSSOCallbackReceived(apiKey, apiSecret);
      }
    }
  }
}
