import 'package:brasil_fields/brasil_fields.dart';

extension NumUtils on num {
  String get percentage {
    final List<String> numbers = toString().split('.');

    if (numbers.isEmpty || numbers.length == 1) return toString();

    if (numbers.last.length == 1) {
      if (numbers.last == '0') return numbers.first;

      final value = '${numbers.first}.${numbers.last}';
      return value;
    }

    final decimalString = numbers.last.substring(0, 2);

    if (decimalString.length > 1 && decimalString.substring(1) == '0') {
      final value = '${numbers.first}.${decimalString.substring(0, 1)}';
      return value;
    }

    if (decimalString.length > 1) {
      final value = '${numbers.first}.${decimalString.substring(0, 2)}';
      return value;
    }

    return numbers.first;
  }

  String get countFormatted {
    if (this > 9999 && this < 99999) {
      return (this / 1000).toStringAsFixed(1);
    } else if (this > 99999 && this < 999999) {
      return (this / 1000).toStringAsFixed(1);
    } else if (this > 999999 && this < 999999999) {
      return (this / 1000000).toStringAsFixed(1);
    } else if (this > 999999999) {
      return (this / 1000000000).toStringAsFixed(1);
    } else {
      return toString();
    }
  }

  String get countDescriptionFormatted {
    if (this > 9999 && this < 999999) {
      return 'K';
    } else if (this > 999999 && this < 999999999) {
      return 'M';
    } else if (this > 999999999) {
      return 'B';
    } else {
      return '';
    }
  }

  String get countAndDescriptionFormatted => '$countFormatted$countDescriptionFormatted';

  String get counterFormatted {
    late String total;

    if (this > 9999 && this <= 999999) {
      String value = (this / 1000).toStringAsFixed(1);
      if (value.endsWith('.0')) value = value.substring(0, value.length - 2);
      total = '${value}K';
    } else if (this > 999999 && this <= 999999999) {
      String value = (this / 1000000).toStringAsFixed(1);
      if (value.endsWith('.0')) value = value.substring(0, value.length - 2);
      total = '${value}M';
    } else if (this > 999999999) {
      String value = (this / 1000000000).toStringAsFixed(1);
      if (value.endsWith('.0')) value = value.substring(0, value.length - 2);
      total = '${value}B';
    } else {
      String value = toStringAsFixed(1);
      if (value.endsWith('.0')) value = value.substring(0, value.length - 2);
      total = value;
      if (this > 999 && this <= 9999) total = '${total.substring(0, 1)}.${total.substring(1)}';
    }

    return total;
  }

  String get formattedMoneyBR => UtilBrasilFields.obterReal(toDouble());
  // NumberFormat.simpleCurrency(locale: Get.locale?.languageCode, decimalDigits: 2).format(this);

  String get formattedMoneySimple => UtilBrasilFields.obterReal(toDouble(), moeda: false, decimal: 0);
  // NumberFormat.simpleCurrency(locale: Get.locale?.languageCode, decimalDigits: 0, name: '').format(this);
}
