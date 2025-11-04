import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:titiknol/models/user_voucher.dart' as user_voucher_model;
import 'package:titiknol/apps/voucher/viewmodels/user_voucher.dart';
import 'package:titiknol/apps/voucher/views/user_voucher_detail.dart';
import 'package:titiknol/pkg/helpers/widget_helper.dart';
import 'package:titiknol/pkg/const/labels.dart' as const_labels;
import 'package:titiknol/pkg/views/loading_overlay/loading_overlay.dart';
import 'package:titiknol/pkg/helpers/datetime_helper.dart';

class UserTask extends StatefulWidget {
  const UserTask({super.key});

  @override
  State<UserTask> createState() => _UserTaskState();
}

class _UserTaskState extends State<UserTask> {
  final ScrollController _scrollController = ScrollController();
  late UserVoucherViewModel userVoucherViewModel;
  late WidgetHelper widgetHelper;

  @override
  void initState() {
    super.initState();
    userVoucherViewModel = Get.find();

    // Listener untuk pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !userVoucherViewModel.isLoadingMore.value) {
        userVoucherViewModel.fetchUserVouchers();
      }
    });

    // Load data awal
    userVoucherViewModel.fetchUserVouchers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goToDetailUserTask(user_voucher_model.UserVoucher userVoucher) {
    Get.to(() => const LoadingOverlay(child: UserVoucherDetail()),
        arguments: userVoucher);
  }

  Widget userVoucherList() {
    return Obx(() {
      int articleLength = userVoucherViewModel.items.length;
      if (articleLength == 0) {
        return SizedBox(
          height: widgetHelper.heightScreen, // ambil tinggi layar penuh
          width: double.infinity, // lebar penuh
          child: const Center(
            child: Text(const_labels.labelEmptyUserVoucher),
          ),
        );
      } else {
        return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true, // penting agar tidak konflik dengan scroll luar
            physics: const ClampingScrollPhysics(),
            itemCount: articleLength,
            itemBuilder: (context, index) {
              final userVoucher = userVoucherViewModel.items[index];
              return GestureDetector(
                onTap: () {
                  _goToDetailUserTask(userVoucher);
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      widgetHelper.createImage(
                          userVoucher.image,
                          widgetHelper.widthScreen * 0.3,
                          widgetHelper.heightScreen * 0.1),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userVoucher.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            widgetHelper.textLabel(
                                formatJakartaDate(userVoucher.createdAt))
                            // Text("Created at: ${article.created_at}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widgetHelper = WidgetHelper(context);
    return RefreshIndicator(
      onRefresh: () async {
        userVoucherViewModel.resetPagination();
        await userVoucherViewModel.fetchUserVouchers();
      },
      child: SizedBox(
          height: widgetHelper.heightScreen * 0.8,
          child: SizedBox(
            height: widgetHelper.heightScreen, // ambil tinggi layar penuh
            width: double.infinity, // lebar penuh
            child: const Center(
              child: Text(const_labels.labelEmptyUserTask),
            ),
          )
          // child: SingleChildScrollView(
          //   controller: _scrollController,
          //   physics: const AlwaysScrollableScrollPhysics(),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: userVoucherList(),
          //   ),
          // ),
          ),
    );
  }
}
