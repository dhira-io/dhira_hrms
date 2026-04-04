import 'dart:async';

class SessionManager {
  final _sessionExpiredController = StreamController<void>.broadcast();

  Stream<void> get sessionExpiredStream => _sessionExpiredController.stream;

  void triggerSessionExpired() {
    _sessionExpiredController.add(null);
  }

  void dispose() {
    _sessionExpiredController.close();
  }
}
