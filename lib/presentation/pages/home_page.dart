import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sqlite_getx/business_logic/home/home_controller.dart';
import 'package:sqlite_getx/presentation/widgets/review_tile.dart';
import 'package:sqlite_getx/shared/widgets/loading_view.dart';

class HomePage extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => homeController.setReverse(),
        onPressed: () => homeController.setReverseStream(),
        child: const Icon(
          CupertinoIcons.arrow_2_circlepath,
        ),
      ),
      body: Center(
        child: Obx(
          () => homeController.error.value.isNotEmpty
              ? Text(homeController.error.value)
              : homeController.isLoading.value
                  ? const LoadingView()
                  : WithStream(),
                  // : WithoutStream(),
        ),
      ),
    );
  }
}

class WithStream extends StatelessWidget {
  WithStream({
    Key? key,
  }) : super(key: key);

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: homeController.streamController.stream,
        initialData: false,
        builder: (context, snapshot) {
          return GroupedListView<dynamic, String>(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            physics: const BouncingScrollPhysics(),
            elements: homeController.reviewList,
            groupBy: (element) => element.createdAt!.substring(0, 10),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            order:
                snapshot.data! ? GroupedListOrder.DESC : GroupedListOrder.ASC,
            separator: const SizedBox(height: 20),
            groupSeparatorBuilder: (String value) => Column(
              children: [
                const Divider(color: Colors.blue),
                Text(
                  value.substring(0, 10),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                ),
              ],
            ),
            itemBuilder: (c, element) => ReviewTile(review: element),
          );
        });
  }
}

class WithoutStream extends StatelessWidget {
  WithoutStream({
    Key? key,
  }) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      physics: const BouncingScrollPhysics(),
      elements: homeController.reviewList,
      groupBy: (element) => element.createdAt!.substring(0, 10),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      order: homeController.isReversed.value
          ? GroupedListOrder.DESC
          : GroupedListOrder.ASC,
      separator: const SizedBox(height: 20),
      groupSeparatorBuilder: (String value) => Column(
        children: [
          const Divider(color: Colors.blue),
          Text(
            value.substring(0, 10),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const Divider(
            color: Colors.blue,
          ),
        ],
      ),
      itemBuilder: (c, element) => ReviewTile(review: element),
    );
  }
}
