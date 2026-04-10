import 'package:app_links/app_links.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';

class DeepLinkService {
  late final AppLinks _appLinks;
  final AuthBloc _authBloc;

  DeepLinkService(this._authBloc) {
    _initDeepLinks();
  }

  void _initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle cold start
    final uri = await _appLinks.getInitialLink();
    if (uri != null) _handleIncomingUri(uri);

    // Handle app running in background/foreground
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) _handleIncomingUri(uri);
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
        _authBloc.add(AuthEvent.ssoCallbackReceived(apiKey, apiSecret));
      }
    }
  }
}
