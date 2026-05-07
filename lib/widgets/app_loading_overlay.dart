import 'package:flutter/widgets.dart';
import 'package:fts/widgets/widgets.dart';

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    this.size,
    required this.isLoading,
    this.child,
  });

  final double? size;
  final bool isLoading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Opacity(
          opacity: isLoading ? 0.2 : 1,
          child: AbsorbPointer(absorbing: isLoading, child: child),
        ),
        if (isLoading) const Center(child: AppSpinner()),
      ],
    );
  }
}
