import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/spacing.dart';
import '../widgets/buttons/text_button.dart';
import 'state_search_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextButton(
            text: 'Change location',
            function: () => navigator.popAndPushNamed(StateSearchScreen.id),
          ),
          AppSpacing.bigVerticalSpacer,
          CustomTextButton.red(
            text: 'Share this app',
            icon: Icons.share,
            function: () => Share.share(
              'Share this app! https://github.com/Illusion47586/covid_resources-india',
            ),
          ),
          AppSpacing.bigVerticalSpacer,
          CustomTextButton.green(
            text: 'About us',
            icon: Icons.info_outline,
            function: () => launch(
                'https://github.com/Illusion47586/covid_resources-india,'),
          ),
        ],
      ),
    );
  }
}
