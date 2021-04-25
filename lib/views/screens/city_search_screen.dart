import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../data/cities.dart';
import '../controllers/city_search_controller.dart';
import '../widgets/forms/search_bar.dart';

class CitySearchScreen extends StatelessWidget {
  static const String id = '/city-search-screen';
  CitySearchScreen({Key key}) : super(key: key);

  final CitySearchController controller = Get.put(CitySearchController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CitySearchController>(
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
                      hintText: 'Search city',
                      listItem: (index, results, context) => ListTile(
                        title: Text(
                          results[index],
                          style: kTextTitle2Style.copyWith(fontSize: 18),
                        ),
                        onTap: () async {
                          print(cities[controller.stateIndex]
                              .indexOf(results[index]));
                          await controller.updateIndex(
                              cities[controller.stateIndex]
                                  .indexOf(results[index]));
                        },
                      ),
                      searchFunction: (context, data) =>
                          cities[controller.stateIndex]
                              .where((element) => element.contains(data))
                              .toList(),
                      errorItem: Container(),
                      defaultItem: (context) => cities[controller.stateIndex]
                          .map(
                            (e) => ListTile(
                              title: Text(
                                e,
                                style: kTextTitle2Style.copyWith(fontSize: 18),
                              ),
                              onTap: () async {
                                print(cities[controller.stateIndex].indexOf(e));

                                await controller.updateIndex(
                                    cities[controller.stateIndex].indexOf(e));
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
