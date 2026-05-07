import 'package:flutter/widgets.dart';

class AppNavigationBarController extends ChangeNotifier {
  AppNavigationBarController({int initialPage = 0, required this.totalPages})
    : assert(initialPage >= 0 && totalPages > initialPage),
      _index = initialPage;

  int _index;
  final int totalPages;

  int get current => _index;

  void changePage(int index) {
    assert(index >= 0 && index < totalPages);

    _index = index;
    notifyListeners();
  }
}
