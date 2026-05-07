class AppConfig {
  const AppConfig({
    required this.apiUri,
    required this.pipeUri,
    required this.kratosUri,
    required this.healthCheckUri,
  }) : debugMode = false,
       showDebugOverlay = false;

  AppConfig.debug({
    required this.apiUri,
    required this.pipeUri,
    required this.kratosUri,
    required this.healthCheckUri,
    this.showDebugOverlay = true,
  }) : debugMode = true;

  final Uri apiUri;
  final Uri pipeUri;
  final bool debugMode;
  final Uri kratosUri;
  final Uri healthCheckUri;
  final bool showDebugOverlay;
}
