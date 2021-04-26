import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../core/theme/spacing.dart';
import '../../data/cities.dart';
import '../../data/states.dart';
import '../widgets/forms/search_bar.dart';

class TestScreen extends StatefulWidget {
  static const String id = '/test-screen';
  TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Center(
            child: Column(
              children: [
                Flexible(
                  child: SearchBar(
                    controller: FloatingSearchBarController(),
                    stream: Connectivity().onConnectivityChanged,
                    hintText: 'Search State',
                    listItem: (index, results, context) => ListTile(
                      title: Text(results[index]),
                      onTap: () {
                        print(stateList.indexOf(results[index]));
                        setState(() {
                          _selectedIndex = stateList.indexOf(results[index]);
                        });
                      },
                    ),
                    searchFunction: (context, data) => stateList
                        .where((element) => element.contains(data))
                        .toList(),
                    errorItem: Container(),
                    defaultItem: (context) => [Container()],
                    failCondition: (data) => data != ConnectivityResult.none,
                  ),
                ),
                Flexible(
                  child: SearchBar(
                    controller: FloatingSearchBarController(),
                    stream: Connectivity().onConnectivityChanged,
                    hintText: 'Search city / district',
                    listItem: (index, results, context) => ListTile(
                      title: Text(results[index]),
                    ),
                    searchFunction: (context, data) => cities[_selectedIndex]
                        .where((element) => element.contains(data))
                        .toList(),
                    errorItem: Container(),
                    defaultItem: (context) => cities[_selectedIndex]
                        .map(
                          (e) => ListTile(
                            title: Text(e),
                          ),
                        )
                        .toList(),
                    failCondition: (data) => data != ConnectivityResult.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
