import 'backend_client.dart';
import 'mailbox_client_proxy.dart';
import 'mailpit_client.dart';

final class ApiClients {
  final backendClient = BackendClient();
  final mailbox = MailboxClientProxy();
  final mailpitClient = MailpitClient();
}
