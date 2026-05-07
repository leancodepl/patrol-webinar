import 'package:flutter/widgets.dart';

abstract final class AppSpacings {
  static const zero = AppSpacing._(0);
  static const s4 = AppSpacing._(4);
  static const s8 = AppSpacing._(8);
  static const s12 = AppSpacing._(12);
  static const s16 = AppSpacing._(16);
  static const s24 = AppSpacing._(24);
  static const s32 = AppSpacing._(32);
  static const s40 = AppSpacing._(40);
  static const s48 = AppSpacing._(48);
  static const s56 = AppSpacing._(56);
  static const s64 = AppSpacing._(64);
  static const s72 = AppSpacing._(72);
  static const s80 = AppSpacing._(80);

  static const content = s16;
}

final class AppSpacing {
  const AppSpacing._(this.value);

  final double value;

  EdgeInsetsDirectional get all => EdgeInsetsDirectional.all(value);

  EdgeInsetsDirectional get horizontal =>
      EdgeInsetsDirectional.symmetric(horizontal: value);
  EdgeInsetsDirectional get vertical =>
      EdgeInsetsDirectional.symmetric(vertical: value);

  EdgeInsetsDirectional get start => EdgeInsetsDirectional.only(start: value);
  EdgeInsetsDirectional get end => EdgeInsetsDirectional.only(end: value);
  EdgeInsetsDirectional get top => EdgeInsetsDirectional.only(top: value);
  EdgeInsetsDirectional get bottom => EdgeInsetsDirectional.only(bottom: value);

  SizedBox get horizontalSpace => SizedBox(width: value);
  SizedBox get verticalSpace => SizedBox(height: value);

  SliverToBoxAdapter get horizontalSpaceSliver =>
      SliverToBoxAdapter(child: horizontalSpace);

  SliverToBoxAdapter get verticalSpaceSliver =>
      SliverToBoxAdapter(child: verticalSpace);
}

extension ScreenHorizontalPaddingExtension on Widget {
  Widget get screenHorizontalPadding {
    return Padding(padding: AppSpacings.content.horizontal, child: this);
  }
}
