/// Runtime config. Pass `--dart-define=BACKEND_URL=https://...` when a
/// Cloud Function is deployed. When empty, orders are accepted locally so
/// the MVP can be demoed without secrets in the app.
abstract final class AppConfig {
  static const backendUrl = String.fromEnvironment('BACKEND_URL');

  static bool get hasRemoteBackend => backendUrl.isNotEmpty;
}
