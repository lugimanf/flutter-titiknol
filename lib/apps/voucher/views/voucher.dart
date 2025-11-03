import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/voucher/views/user_voucher.dart';
import 'package:titiknol/apps/voucher/views/voucher_list.dart';
import 'package:titiknol/apps/voucher/viewmodels/user_voucher.dart';
import 'package:titiknol/apps/voucher/viewmodels/voucher_list.dart';

// Controller buat handle perubahan tab dari mana aja
class VoucherTabController extends GetxController {
  late TabController tabController;

  void setController(TabController controller) {
    tabController = controller;
  }

  void changeTab(int index) {
    tabController.animateTo(index);
  }
}

class Voucher extends StatefulWidget {
  const Voucher({super.key});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final voucherTabController = Get.put(VoucherTabController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    voucherTabController.setController(_tabController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserVoucherViewModel userVoucherViewModel = Get.put(UserVoucherViewModel());
    VoucherListViewModel voucherListViewModel = Get.put(VoucherListViewModel());
    userVoucherViewModel = Get.put(UserVoucherViewModel());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Voucherku'),
                Tab(text: 'Tukar'),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  UserVoucher(),
                  VoucherList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
