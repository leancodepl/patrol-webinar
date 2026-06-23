class MailpitClient {
  String generateRandomEmailAddress() {
    return 'user-${DateTime.now().millisecondsSinceEpoch}@fts.test.lncd.pl';
  }
}
