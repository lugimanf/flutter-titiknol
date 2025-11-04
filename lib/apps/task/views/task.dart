import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:titiknol/apps/task/views/user_task.dart';
import 'package:titiknol/apps/task/views/task_list.dart';
import 'package:titiknol/apps/task/viewmodels/user_task.dart';
import 'package:titiknol/apps/task/viewmodels/task_list.dart';

import 'package:titiknol/pkg/const/labels.dart' as const_label;

// Controller buat handle perubahan tab dari mana aja
class TaskTabController extends GetxController {
  late TabController tabController;

  void setController(TabController controller) {
    tabController = controller;
  }

  void changeTab(int index) {
    tabController.animateTo(index);
  }
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final taskTabController = Get.put(TaskTabController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    taskTabController.setController(_tabController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserTaskViewModel userTaskViewModel = Get.put(UserTaskViewModel());
    TaskListViewModel taskListViewModel = Get.put(TaskListViewModel());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: const_label.tabLabelMyTask),
                Tab(text: const_label.tabLabelTaskList),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  UserTask(),
                  TaskList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
