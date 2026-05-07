import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

final class AppTextAreaDecoration with EquatableMixin {
  const AppTextAreaDecoration({
    this.label,
    this.placeholder,
    this.helpKey,
    this.help,
    this.hint,
    this.error,
  });

  final String? label;
  final String? placeholder;
  final Key? helpKey;
  final String? help;
  final String? hint;
  final String? error;

  @override
  List<Object?> get props => [label, placeholder, helpKey, help, hint, error];
}
