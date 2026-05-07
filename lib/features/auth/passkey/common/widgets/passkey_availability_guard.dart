import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/passkey/common/passkey_credential_manager/passkey_credential_manager.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class PasskeyAvailabilityGuard extends HookWidget {
  const PasskeyAvailabilityGuard({
    required this.child,
    this.initialAvailability = true,
    this.placeholderBuilder = _defaultPlaceholderBuilder,
    super.key,
  });

  final Widget child;
  final bool initialAvailability;
  final WidgetBuilder placeholderBuilder;

  static Widget _defaultPlaceholderBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final availabilitySnapshot = useFuture(
      useMemoized(
        () => context.read<PasskeyCredentialManager>().checkAvailability(),
      ),
    );

    final available = availabilitySnapshot.data ?? initialAvailability;

    if (!available) {
      return placeholderBuilder(context);
    }

    return child;
  }
}
