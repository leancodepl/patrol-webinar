typedef V = PatrolEnvVariable;

sealed class PatrolEnvVariable {
  const PatrolEnvVariable();

  static const domainName = String.fromEnvironment('DOMAIN_NAME');
  static const email = String.fromEnvironment('EMAIL');
  static const firstName = String.fromEnvironment('FIRSTNAME');
  static const lastName = String.fromEnvironment('LASTNAME');
  static const mailpitLogin = String.fromEnvironment('MAILPIT_LOGIN');
  static const mailpitPassword = String.fromEnvironment('MAILPIT_PASSWORD');
  static const password = String.fromEnvironment('PASSWORD');
}
