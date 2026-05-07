import 'package:flutter/widgets.dart';
import 'package:fts/widgets/widgets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: const Center(child: AppSpinner()));
  }
}
