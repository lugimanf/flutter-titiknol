import 'package:flutter/material.dart';

import 'package:titiknol/pkg/const/assets.dart' as const_assets;
import 'package:titiknol/apps/voucher/views/voucher_user.dart';
import 'package:titiknol/apps/voucher/views/voucher_list.dart';

const double sizeBoxForLoginWithGoogle = 5;
const double sizeBoxHeightDistanceEachButton = 7;
const double sizeBoxHeightDistanceEachEdtText = 16;

class Voucher extends StatefulWidget {
  const Voucher({super.key});

  @override
  State<Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          child: const SafeArea(
            child: Column(
              children: [
                // TabBar di tengah
                TabBar(
                  tabs: [
                    Tab(text: 'My Voucher'),
                    Tab(text: 'Buy'),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                ),
                // Konten Login & Register
                const Expanded(
                  child: TabBarView(
                    children: [
                      VoucherList(),
                      VoucherUser(),
                    ],
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
