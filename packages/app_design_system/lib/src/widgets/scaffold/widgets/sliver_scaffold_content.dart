import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class SliverScaffoldContent extends StatelessWidget {
  SliverScaffoldContent({
    super.key,
    this.itemExtent,
    this.itemExtentBuilder,
    this.prototypeItem,
    required List<Widget> children,
  }) : delegate = SliverChildListDelegate(children);

  SliverScaffoldContent.builder({
    super.key,
    this.itemExtent,
    this.itemExtentBuilder,
    this.prototypeItem,
    required int? itemCount,
    required NullableIndexedWidgetBuilder builder,
  }) : delegate = SliverChildBuilderDelegate(builder, childCount: itemCount);

  SliverScaffoldContent.separated({
    super.key,
    required int? itemCount,
    required NullableIndexedWidgetBuilder builder,
    IndexedWidgetBuilder? separatorBuilder,
  }) : itemExtent = null,
       itemExtentBuilder = null,
       prototypeItem = null,
       delegate = SliverChildBuilderDelegate(
         childCount: switch (itemCount) {
           final itemCount? =>
             itemCount + (separatorBuilder != null ? max(0, itemCount - 1) : 0),
           null => null,
         },
         semanticIndexCallback: (_, index) => index.isEven ? index ~/ 2 : null,
         (context, index) {
           if (separatorBuilder case final separatorBuilder?) {
             return index.isEven
                 ? builder(context, index ~/ 2)
                 : separatorBuilder(context, index ~/ 2);
           }

           return builder(context, index);
         },
       );

  final SliverChildDelegate delegate;
  final double? itemExtent;
  final ItemExtentBuilder? itemExtentBuilder;
  final Widget? prototypeItem;

  @override
  Widget build(BuildContext context) {
    if (prototypeItem case final prototypeItem?) {
      return SliverPrototypeExtentList(
        prototypeItem: prototypeItem,
        delegate: delegate,
      );
    }

    if (itemExtentBuilder case final builder?) {
      return SliverVariedExtentList(
        itemExtentBuilder: builder,
        delegate: delegate,
      );
    }

    if (itemExtent case final itemExtent?) {
      return SliverFixedExtentList(itemExtent: itemExtent, delegate: delegate);
    }

    return SliverList(delegate: delegate);
  }
}
