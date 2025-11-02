import 'package:get/get.dart';

void exceptionDialogBox(Object e, {title = "info"}) {
  Get.defaultDialog(
    title: title,
    middleText: e.toString().replaceAll('Exception: ', ''),
    textConfirm: "OK",
    onConfirm: () => Get.back(),
  );
}
