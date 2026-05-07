import 'package:flutter/widgets.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

TextEditingController useEffectiveTextEditingController(
  TextEditingController? controller, {
  String? text,
}) {
  final localController = useMemoized(
    () => controller != null ? null : TextEditingController(text: text),
    [controller],
  );
  useEffect(() {
    return () {
      localController?.dispose();
    };
  }, [localController]);

  return controller ?? localController!;
}
