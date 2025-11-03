import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

String formatJakartaDate(DateTime datetime) {
  final jakarta = tz.getLocation('Asia/Jakarta');
  final jakartaTime = tz.TZDateTime.from(datetime, jakarta);
  return DateFormat('d MMM yyyy', 'id_ID').format(jakartaTime);
}