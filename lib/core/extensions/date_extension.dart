import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  /// Result: '2024-04-29'
  String get formatyyyyMMdd => DateFormat('yyyy-MM-dd', Get.locale?.languageCode).format(this);

  /// Result: '29/04/2024'
  String get formatddMMyyyy => DateFormat('dd/MM/yyyy', Get.locale?.languageCode).format(this);

  /// Result: '13:41'
  String get formatHHmm => DateFormat('HH:mm', Get.locale?.languageCode).format(this);

  /// Result: '13:41:05'
  String get formatHHmmss => DateFormat('HH:mm:ss', Get.locale?.languageCode).format(this);

  /// Result: '29/04/2024 13:41:05'
  String get formatddMMyyyyHHmmss => DateFormat('dd/MM/yyyy HH:mm:ss', Get.locale?.languageCode).format(this);

  /// Result: '29/04/2024 13:41'
  String get formatddMMyyyyHHmm => DateFormat('dd/MM/yyyy HH:mm', Get.locale?.languageCode).format(this);

  /// Result: '1234564948111'
  String get timestamp => millisecondsSinceEpoch.toString();

  /// Result: '11/04'
  String get formatddMM => DateFormat('dd/MM', Get.locale?.languageCode).format(this);

  String get dateExtended => DateFormat('dd MMMM yyyy', Get.locale?.languageCode).format(this);

  /// Result: '29/04/2024 13:41:05'
  String get formatMMMM => DateFormat.MMMM(Get.locale?.languageCode).format(this).capitalize!;

  int daysBetween(DateTime from, DateTime to) => (to.difference(from).inHours / 24).floor();

  bool isSameDate(DateTime a) => a.year == year && a.month == month && a.day == day;

  bool isSameDateAndHour(DateTime a) =>
      a.year == year && a.month == month && a.day == day && a.hour == hour && a.minute == minute;
}
