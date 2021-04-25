import 'package:covid_resources/core/models/data_model.dart';
import 'package:covid_resources/core/theme/colors.dart';
import 'package:covid_resources/core/theme/custom_icons_icons.dart';
import 'package:covid_resources/views/screens/settings_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/spacing.dart';
import '../controllers/main_controller.dart';
import 'info_data_screen.dart';

class MainScreen extends StatelessWidget {
  static const String id = '/main-screen';
  MainScreen({Key key}) : super(key: key);

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                ...List.generate(
                  Issue.values.length,
                  (index) => InfoDataScreen(
                    issue: Issue.values[index],
                  ),
                ),
                SettingsScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: controller.selectedIndex.value,
          showElevation: true,
          onItemSelected: controller.updateIndex,
          iconSize: 25,
          height: 70,
          items: [
            FlashyTabBarItem(
              activeColor: AppColors.accentBlueDark,
              inactiveColor: AppColors.accentBlueDark.withOpacity(0.7),
              icon: Icon(CustomIcons.syringe),
              title: Text(
                'Vaccine',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentRedDark,
              inactiveColor: AppColors.accentRedDark.withOpacity(0.7),
              icon: Icon(CustomIcons.lungs),
              title: Text(
                'Oxygen',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentGreenDark,
              inactiveColor: AppColors.accentGreenDark.withOpacity(0.7),
              icon: Icon(CustomIcons.hospital),
              title: Text(
                'Hospital',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentPurpleDark,
              inactiveColor: AppColors.accentPurpleDark.withOpacity(0.7),
              icon: Icon(CustomIcons.blood),
              title: Text(
                'Plasma',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.dark,
              inactiveColor: AppColors.dark.withOpacity(0.7),
              icon: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
