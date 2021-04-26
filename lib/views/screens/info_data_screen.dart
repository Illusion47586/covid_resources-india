import 'package:clipboard/clipboard.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/models/data_model.dart';
import '../../core/theme/custom_icons_icons.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../controllers/main_controller.dart';
import '../widgets/buttons/icon_button.dart';
import '../widgets/buttons/text_button.dart';

class InfoDataScreen extends StatelessWidget {
  final Issue issue;

  const InfoDataScreen({Key key, this.issue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Container(
        padding: EdgeInsets.only(
          top: AppSpacing.screenPadding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding.left,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    EnumToString.convertToString(issue) + ' info',
                    style: kTextHeaderStyle,
                  ),
                  Flexible(
                    child: Text(
                      controller.dataService.getCurrentLocation(),
                      style: kTextTitle2Style.copyWith(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            AppSpacing.mediumVerticalSpacer,
            Flexible(
              child: StreamBuilder<List<DataModel>>(
                stream: controller.dataStream[issue],
                builder: (BuildContext context,
                    AsyncSnapshot<List<DataModel>> snapshot) {
                  if (snapshot.hasData)
                    return kIsWeb
                        ? StaggeredGridView.countBuilder(
                            crossAxisCount: Get.width < 800 ? 1 : 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            padding: EdgeInsets.only(
                              left: AppSpacing.screenPadding.left,
                              right: AppSpacing.screenPadding.right,
                              bottom: 20,
                            ),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildItem(snapshot, index),
                            itemCount: snapshot.data.length,
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(
                              left: AppSpacing.screenPadding.left,
                              right: AppSpacing.screenPadding.right,
                              bottom: 20,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildItem(snapshot, index),
                            itemCount: snapshot.data.length,
                            separatorBuilder: (context, index) =>
                                AppSpacing.smallVerticalSpacer,
                          );
                  else if (snapshot.hasError)
                    return Padding(
                      padding: EdgeInsets.only(
                        left: AppSpacing.screenPadding.left,
                        right: AppSpacing.screenPadding.right,
                        bottom: 20,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(10, 10),
                              blurRadius: 20,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.error.toString(),
                                style: kTextTitle1Style.copyWith(
                                  fontSize: 23,
                                  color: Colors.redAccent,
                                ),
                              ),
                              AppSpacing.bigVerticalSpacer,
                              CustomTextButton.issue(
                                issue: issue,
                                text: 'Willing to contribute?',
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  else
                    return const Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildItem(AsyncSnapshot<List<DataModel>> snapshot, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(10, 10),
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  snapshot.data[index].title,
                  style: kTextTitle2Style.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  'last updated on: ' + snapshot.data[index].datetime,
                  style: kTextTitle2Style.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          AppSpacing.smallVerticalSpacer,
          Text(
            snapshot.data[index].disc,
            style: kTextTitle2Style.copyWith(
              fontSize: 18,
            ),
          ),
          AppSpacing.smallVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              snapshot.data[index].details != null
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            snapshot.data[index].details,
                            style: kTextTitle2Style.copyWith(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            snapshot.data[index].location,
                            style: kTextTitle2Style.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              snapshot.data[index].details != null
                  ? const SizedBox(
                      width: 20,
                    )
                  : const SizedBox(),
              Row(
                children: [
                  CustomIconButton.issue(
                    issue: issue,
                    icon: Icons.map,
                    function: () => launch(snapshot.data[index].locationURL),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomIconButton.issue(
                    issue: issue,
                    icon: kIsWeb ? Icons.copy : CustomIcons.send,
                    function: () async => kIsWeb
                        ? await FlutterClipboard.copy(
                            '*${snapshot.data[index].title}*\n\n${snapshot.data[index].disc}\n${snapshot.data[index].details}\n\nLocation: ${snapshot.data[index].location}\n${snapshot.data[index].locationURL}\n\nLast updated on: ${snapshot.data[index].datetime}',
                          )
                        : Share.share(
                            '*${snapshot.data[index].title}*\n\n${snapshot.data[index].disc}\n${snapshot.data[index].details}\n\nLocation: ${snapshot.data[index].location}\n${snapshot.data[index].locationURL}\n\nLast updated on: ${snapshot.data[index].datetime}',
                          ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
