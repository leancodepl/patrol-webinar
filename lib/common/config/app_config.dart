class AppConfig {
  const AppConfig({
    required this.apiUri,
    required this.pipeUri,
    required this.kratosUri,
    required this.healthCheckUri,
    this.enableForceUpdate = false,
  }) : debugMode = false,
       showDebugOverlay = false;

  AppConfig.debug({
    required this.apiUri,
    required this.pipeUri,
    required this.kratosUri,
    required this.healthCheckUri,
    this.showDebugOverlay = true,
    this.enableForceUpdate = false,
  }) : debugMode = true;

  final Uri apiUri;
  final Uri pipeUri;
  final bool debugMode;
  final Uri kratosUri;
  final Uri healthCheckUri;
  final bool showDebugOverlay;

  /// Whether the `ForceUpdateGuard` performs the live `VersionSupport` check on
  /// startup. Off by default because this open-source example has no backend
  /// serving that query; enable it in environments where the endpoint exists
  /// (e.g. the Patrol force-update test).
  final bool enableForceUpdate;
}
