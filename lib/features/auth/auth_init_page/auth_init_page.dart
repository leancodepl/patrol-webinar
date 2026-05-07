import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/features/auth/kratos/auth_cubit.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class AuthInitPage extends HookWidget {
  const AuthInitPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    useEffect(() {
      authCubit.init();

      return;
    }, []);

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit,
      builder: (context, state) {
        if (state is! AuthStateInitial) {
          return child;
        }

        return AppScaffold(body: const Center(child: AppSpinner()));
      },
    );
  }
}
