import 'package:flutter/material.dart';

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
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // TabBar di tengah
              TabBar(
                tabs: [
                  Tab(text: 'My Voucher'),
                  Tab(text: 'Change'),
                ],
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
              ),
              // Konten Login & Register
              Expanded(
                child: TabBarView(
                  children: [
                    VoucherUser(),
                    VoucherList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
