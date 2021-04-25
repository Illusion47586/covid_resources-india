import 'package:covid_resources/views/screens/city_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../data/states.dart';
import '../controllers/state_search_controller.dart';
import '../widgets/forms/search_bar.dart';

class StateSearchScreen extends StatelessWidget {
  static const String id = '/state-search-screen';
  StateSearchScreen({Key key}) : super(key: key);

  final StateSearchController controller = Get.put(StateSearchController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateSearchController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Center(
              child: Column(
                children: [
                  Flexible(
                    child: SearchBar(
                      controller: controller.searchBarController,
                      stream: controller.connectionStream,
                      hintText: 'Search State',
                      listItem: (index, results, context) => ListTile(
                        title: Text(
                          results[index],
                          style: kTextTitle2Style.copyWith(fontSize: 18),
                        ),
                        onTap: () {
                          print(stateList.indexOf(results[index]));
                          controller.updateIndex =
                              stateList.indexOf(results[index]);
                          Get.toNamed(CitySearchScreen.id);
                        },
                      ),
                      searchFunction: (context, data) => stateList
                          .where((element) => element.contains(data))
                          .toList(),
                      errorItem: Container(),
                      defaultItem: (context) => stateList
                          .map(
                            (e) => ListTile(
                              title: Text(
                                e,
                                style: kTextTitle2Style.copyWith(fontSize: 18),
                              ),
                              onTap: () {
                                print(stateList.indexOf(e));
                                controller.updateIndex = stateList.indexOf(e);
                                Get.toNamed(CitySearchScreen.id);
                              },
                            ),
                          )
                          .toList(),
                      failCondition: controller.failCondition,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
