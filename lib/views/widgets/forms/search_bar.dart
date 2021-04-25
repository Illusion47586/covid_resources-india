import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:logger/logger.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    Key key,
    this.controller,
    this.hintText,
    this.searchFunction,
    this.listItem,
    this.defaultItem,
    this.stream,
    this.errorItem,
    this.failCondition,
  }) : super(key: key);

  final FloatingSearchBarController controller;
  final String hintText;
  final List<dynamic> Function(BuildContext context, String data)
      searchFunction;
  final Widget Function(int index, List<dynamic> results, BuildContext context)
      listItem;
  final List<Widget> Function(BuildContext context) defaultItem;
  final Stream stream;
  final Widget errorItem;
  final bool Function(dynamic data) failCondition;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List results = [];
  bool progress = false;

  void getResults(String data) async {
    if (data.isNotEmpty) {
      setState(() {
        results = [];
        progress = true;
      });

      results = widget.searchFunction(context, data);

      Logger().v(results);

      setState(() {
        progress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: '${widget.hintText}',
      hintStyle: kTextTitle2Style.copyWith(fontSize: 18),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 0),
      borderRadius: BorderRadius.circular(12),
      queryStyle: kTextTitle2Style.copyWith(fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      margins: EdgeInsets.zero,
      controller: widget.controller,
      progress: progress,
      backgroundColor: Colors.grey.shade200,
      clearQueryOnClose: true,
      closeOnBackdropTap: true,
      shadowColor: Colors.black12,
      backdropColor: Colors.transparent,
      textInputType: TextInputType.streetAddress,
      elevation: 0,
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      openWidth: Get.width - 2 * AppSpacing.screenPadding.left,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: getResults,
      onSubmitted: getResults,
      transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
          size: 25,
        ),
      ],
      toolbarOptions: const ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: StreamBuilder(
              stream: widget.stream,
              builder: (context, snapshot) {
                if (widget.failCondition(snapshot.data)) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ListTile.divideTiles(
                      context: context,
                      color: Colors.black45,
                      tiles: widget.controller.query.isNotEmpty
                          ? List.generate(
                              results.length,
                              (index) => widget.listItem(
                                index,
                                results,
                                context,
                              ),
                            )
                          : widget.defaultItem(context),
                    ).toList(),
                  );
                } else
                  return widget.errorItem;
              },
            ),
          ),
        );
      },
    );
  }
}
