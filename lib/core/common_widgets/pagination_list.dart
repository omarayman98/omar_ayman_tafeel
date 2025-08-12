import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// {@template paginated_list}
/// A Paginated List widget that displays a list of items in a scrollable
/// container. The list can be scrolled horizontally or vertically. The list
/// can be infinite, meaning that it will request additional items as the
/// user scrolls.
/// {@endtemplate}
class PaginatedListWidget<T> extends StatefulWidget {
  /// {@macro paginated_list}
  const PaginatedListWidget({
    super.key,
    this.onTap,
    this.onRemove,
    this.loadingIndicator = const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    ),
    this.deleteIcon = const Icon(
      Icons.close,
      color: Colors.white,
    ),
    this.physics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    this.deleteIconAlignment = Alignment.centerRight,
    this.padding = EdgeInsets.zero,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.controller,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.findChildIndexCallback,
    this.cacheExtent,
    this.itemExtent,
    this.primary,
    this.reverse = false,
    this.shrinkWrap = false,
    this.prototypeItem,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.semanticChildCount,
    this.listViewKey,
    this.isRecentSearch = false,
    required this.onLoadMore,
    required this.builder,
    required this.items,
    required this.isLastPage,
  });

  /// The list of items to display.
  final List<T> items;

  /// The function that is called when the user taps an item.
  final dynamic Function(int index)? onTap;

  /// The function that is called when the user requests more items.
  final dynamic Function() onLoadMore;

  /// The function that is called when the user taps the delete icon.
  final dynamic Function(T item, int index)? onRemove;

  /// The function that is called to build the items of the list.
  final Widget Function(T item, int index) builder;

  /// The widget to display while the list is loading.
  final Widget loadingIndicator;

  /// The icon to display for the delete button.
  final Widget deleteIcon;

  /// The scroll physics to use for the list.
  final ScrollPhysics physics;

  /// The scroll direction of the list.
  final Axis scrollDirection;

  /// Whether the list is displaying recent searches.
  final bool isRecentSearch;

  /// Whenever the list is displaying the last page of results.
  final bool isLastPage;

  /// The ListView [addAutomaticKeepAlives] parameter.
  final bool addAutomaticKeepAlives;

  /// The ListView [addRepaintBoundaries] parameter.
  final bool addRepaintBoundaries;

  /// The ListView [addSemanticIndexes] parameter.
  final bool addSemanticIndexes;

  /// The ListView [cacheExtent] parameter.
  final double? cacheExtent;

  /// The ListView [clipBehavior] parameter.
  final Clip clipBehavior;

  /// The ListView [controller] parameter.
  final ScrollController? controller;

  /// The ListView [dragStartBehavior] parameter.
  final DragStartBehavior dragStartBehavior;

  /// The ListView [findChildIndexCallback] parameter.
  final int? Function(Key)? findChildIndexCallback;

  /// The ListView [itemExtent] parameter.
  final double? itemExtent;

  /// The ListView [primary] parameter.
  final bool? primary;

  /// The ListView [reverse] parameter.
  final bool reverse;

  /// The ListView [shrinkWrap] parameter.
  final bool shrinkWrap;

  /// The ListView [prototypeItem] parameter.
  final Widget? prototypeItem;

  /// The ListView [restorationId] parameter.
  final String? restorationId;

  /// The ListView [keyboardDismissBehavior] parameter.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// The ListView [semanticChildCount] parameter.
  final int? semanticChildCount;

  /// The ListView [listViewKey] parameter.
  final Key? listViewKey;

  /// The padding of the [PaginatedList].
  final EdgeInsetsGeometry padding;

  /// The alignment of the [deleteIcon].
  final Alignment deleteIconAlignment;

  @override
  State<PaginatedListWidget<T>> createState() => _PaginatedListState<T>();
}

class _PaginatedListState<T> extends State<PaginatedListWidget<T>> {
  final ScrollController _scrollController = ScrollController();

  Timer? _debounceTimer;

  bool isLoadingMore = false;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  } // Add this flag

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isScrollCloseToEnd() && !widget.isLastPage && !isLoadingMore) {
      isLoadingMore = true;
      print('more');
      widget.onLoadMore().then((_) {
        print('more 1');

        isLoadingMore = false;
      });
    }
  }

  bool _isScrollCloseToEnd() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    return maxScroll == _scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.items.length +
        (widget.isRecentSearch || widget.isLastPage ? 0 : 1);
    return ListView.builder(
      key: widget.listViewKey,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: _scrollController,
      primary: widget.primary,
      restorationId: widget.restorationId,
      semanticChildCount: widget.semanticChildCount,
      shrinkWrap: widget.shrinkWrap,
      prototypeItem: widget.prototypeItem,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      padding: widget.padding,
      itemExtent: widget.itemExtent,
      findChildIndexCallback: widget.findChildIndexCallback,
      dragStartBehavior: widget.dragStartBehavior,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      clipBehavior: widget.clipBehavior,
      physics: widget.physics,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            InkWell(
              onTap: () => widget.onTap?.call(index),
              child: Builder(
                builder: (context) {
                  if (index == widget.items.length) {
                    return widget.loadingIndicator;
                  } else {
                    final item = widget.items[index];
                    return widget.builder.call(item, index);
                  }
                },
              ),
            ),
            if (widget.isRecentSearch)
              Builder(
                builder: (context) {
                  final item = widget.items[index];
                  return Align(
                    alignment: widget.deleteIconAlignment,
                    child: IconButton(
                      onPressed: () {
                        if (item != null) {
                          widget.onRemove?.call(item, index);
                        }
                      },
                      icon: widget.deleteIcon,
                    ),
                  );
                },
              )
          ],
        );
      },
    );
  }
}
