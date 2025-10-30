import 'package:get/get.dart';

void exceptionDialogBox(Object e, {title = "Info"}) {
  Get.defaultDialog(
    title: "Info",
    middleText: e.toString().replaceFirst('Exception: ', ''),
    textConfirm: "OK",
    onConfirm: () => Get.back(),
  );
}
