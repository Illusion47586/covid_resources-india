<<<<<<< HEAD
import '../../core/models/data_model.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/custom_icons_icons.dart';
import 'settings_screen.dart';
=======
>>>>>>> dev
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

<<<<<<< HEAD
=======
import '../../core/models/data_model.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/custom_icons_icons.dart';
>>>>>>> dev
import '../controllers/main_controller.dart';
import 'info_data_screen.dart';
import 'settings_screen.dart';

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
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                ...List.generate(
                  Issue.values.length,
                  (index) => InfoDataScreen(
                    issue: Issue.values[index],
                  ),
                ),
                const SettingsScreen(),
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
              icon: const Icon(CustomIcons.syringe),
              title: const Text(
                'Vaccine',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentRedDark,
              inactiveColor: AppColors.accentRedDark.withOpacity(0.7),
              icon: const Icon(CustomIcons.lungs),
              title: const Text(
                'Oxygen',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentGreenDark,
              inactiveColor: AppColors.accentGreenDark.withOpacity(0.7),
              icon: const Icon(CustomIcons.hospital),
              title: const Text(
                'Hospital',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.accentPurpleDark,
              inactiveColor: AppColors.accentPurpleDark.withOpacity(0.7),
              icon: const Icon(CustomIcons.blood),
              title: const Text(
                'Plasma',
                style: TextStyle(fontSize: 16),
              ),
            ),
            FlashyTabBarItem(
              activeColor: AppColors.dark,
              inactiveColor: AppColors.dark.withOpacity(0.7),
              icon: const Icon(Icons.settings),
              title: const Text(
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
