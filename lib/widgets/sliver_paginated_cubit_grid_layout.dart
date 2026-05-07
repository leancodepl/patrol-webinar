import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';

/// A builder for a paginated grid item.
typedef PaginatedItemBuilder<TData, TItem> =
    Widget Function(
      BuildContext context,
      TData? data,
      int index,
      List<TItem> items,
    );

/// A builder for a widget using the paginated state and data.
typedef PaginatedWidgetBuilder<TData, TItem> =
    Widget Function(BuildContext context, PaginatedState<TData, TItem> state);

/// A builder for the error state widget in PaginatedCubitLayout.
typedef PaginatedErrorBuilder<TItem> =
    Widget Function(BuildContext context, Object? error, VoidCallback retry);

/// A layout for a paginated cubit.
class SliverPaginatedCubitGridLayout<TData, TItem> extends StatelessWidget {
  /// Creates a PaginatedCubitGridLayout.
  const SliverPaginatedCubitGridLayout({
    super.key,
    required this.cubit,
    required this.itemBuilder,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisCount,
    this.initialStateBuilder,
    this.emptyStateBuilder,
    this.firstPageLoadingBuilder,
    this.firstPageErrorBuilder,
    this.nextPageErrorBuilder,
    this.nextPageLoadingBuilder,
  });

  /// The cubit that handles the paginated data.
  final PaginatedCubit<TData, dynamic, dynamic, TItem> cubit;

  /// A builder for a paginated grid item.
  final PaginatedItemBuilder<TData, TItem> itemBuilder;

  /// An optional builder for the initial state.
  final PaginatedWidgetBuilder<TData, TItem>? initialStateBuilder;

  /// An optional builder for the empty state.
  final PaginatedWidgetBuilder<TData, TItem>? emptyStateBuilder;

  /// An optional builder for the loading state of the first page.
  final PaginatedWidgetBuilder<TData, TItem>? firstPageLoadingBuilder;

  /// An optional builder for the error state of the first page.
  final PaginatedErrorBuilder<dynamic>? firstPageErrorBuilder;

  /// An optional builder for the loading state of the next page.
  final PaginatedWidgetBuilder<TData, TItem>? nextPageLoadingBuilder;

  /// An optional builder for the error state of the next page.
  final PaginatedErrorBuilder<dynamic>? nextPageErrorBuilder;

  final double childAspectRatio;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      PaginatedCubit<TData, dynamic, dynamic, TItem>,
      PaginatedState<TData, TItem>
    >(
      bloc: cubit,
      builder: (context, state) {
        return switch (state.type) {
          PaginatedStateType.initial => _buildInitialLoader(context, state),
          PaginatedStateType.firstPageLoading => _buildFirstPageLoader(
            context,
            state,
          ),
          PaginatedStateType.firstPageError || PaginatedStateType.refresh
              when state.hasError =>
            _buildFirstPageError(context, state.error),
          _ => _SliverPaginatedLayoutGrid(
            state: state,
            itemBuilder: itemBuilder,
            fetchNextPage: () => cubit.fetchNextPage(state.args.pageNumber + 1),
            emptyState: _buildEmptyState(context, state),
            bottom: _buildListBottom(context, state),
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisCount: crossAxisCount,
          ),
        };
      },
    );
  }

  Widget _buildInitialLoader(
    BuildContext context,
    PaginatedState<TData, TItem> state,
  ) {
    final config = context.read<PaginatedLayoutConfig>();
    return SliverFillRemaining(
      hasScrollBody: false,
      child:
          initialStateBuilder?.call(context, state) ??
          config.onFirstPageLoading(context),
    );
  }

  Widget _buildFirstPageLoader(
    BuildContext context,
    PaginatedState<TData, TItem> state,
  ) {
    final config = context.read<PaginatedLayoutConfig>();
    return SliverFillRemaining(
      hasScrollBody: false,
      child:
          firstPageLoadingBuilder?.call(context, state) ??
          config.onFirstPageLoading(context),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    PaginatedState<TData, TItem> state,
  ) {
    final config = context.read<PaginatedLayoutConfig>();
    return SliverFillRemaining(
      hasScrollBody: false,
      child:
          emptyStateBuilder?.call(context, state) ??
          config.onEmptyState(context),
    );
  }

  Widget _buildFirstPageError(BuildContext context, Object? error) {
    final config = context.read<PaginatedLayoutConfig>();
    final callback = firstPageErrorBuilder ?? config.onFirstPageError;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: callback(context, error, cubit.refresh),
    );
  }

  Widget? _buildListBottom(
    BuildContext context,
    PaginatedState<TData, TItem> state,
  ) {
    final config = context.read<PaginatedLayoutConfig>();
    if (state.type == PaginatedStateType.nextPageLoading) {
      return nextPageLoadingBuilder?.call(context, state) ??
          config.onNextPageLoading(context);
    } else if (state.type == PaginatedStateType.nextPageError) {
      final callback = nextPageErrorBuilder ?? config.onNextPageError;
      return callback(
        context,
        state.error,
        () => cubit.fetchNextPage(state.args.pageNumber),
      );
    } else {
      return null;
    }
  }
}

class _SliverPaginatedLayoutGrid<TData, TItem> extends StatelessWidget {
  const _SliverPaginatedLayoutGrid({
    required this.state,
    required this.itemBuilder,
    required this.childAspectRatio,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    this.separatorBuilder,
    required this.fetchNextPage,
    required this.emptyState,
    this.bottom,
    this.nextPageThreshold = 3,
  });

  final PaginatedState<TData, TItem> state;
  final PaginatedItemBuilder<TData, TItem> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  final VoidCallback fetchNextPage;
  final Widget emptyState;
  final Widget? bottom;

  /// The number of remaining items that should trigger a new fetch.
  final int nextPageThreshold;

  final double childAspectRatio;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    final items = state.items;

    if (items.isEmpty) {
      return emptyState;
    } else {
      return SliverPadding(
        padding: AppSpacings.s16.horizontal + AppSpacings.s8.vertical,
        sliver: SliverGrid.builder(
          itemBuilder: _itemBuilder,
          itemCount: items.length + (bottom != null ? 1 : 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: childAspectRatio,
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
          ),
        ),
      );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (bottom case final bottom? when index == state.items.length) {
      return bottom;
    }
    final newPageRequestTriggerIndex = max(
      0,
      state.items.length - nextPageThreshold,
    );

    final isBuildingTriggerIndexItem = index == newPageRequestTriggerIndex;

    if (state.hasNextPage &&
        isBuildingTriggerIndexItem &&
        !state.type.shouldNotGetNextPage) {
      fetchNextPage();
    }

    return itemBuilder(context, state.data, index, state.items);
  }
}
