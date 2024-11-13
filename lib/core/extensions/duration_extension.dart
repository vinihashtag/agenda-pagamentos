extension DurationUtils on Duration {
  /// Result: '13:41:05'
  String get toHourMinSec {
    String result = '';
    result += inHours.toString().padLeft(2, '0');
    result += ':';
    result += inMinutes.toString().padLeft(2, '0');
    result += ':';
    result += inSeconds.toString().padLeft(2, '0');

    return result;
  }

  /// Result: '2d 10h'
  String get toDayHourMinText {
    final days = inDays.toString().padLeft(2, '0');
    final hours = inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');

    final result = <String>[];

    if (days != '00') result.add('${days}d');
    if (hours != '00') result.add('${hours}h');
    if (hours != '00' || minutes != '00') result.add('${minutes}m');
    if (hours == '00' && minutes == '00') result.add('${seconds}s');

    return result.join(' ');
  }

  /// Result: '13:41:05'
  String get toHourMinSecText {
    final hours = inHours.toString().padLeft(2, '0');
    final minut = inMinutes.remainder(60).toString().padLeft(2, '0');
    final secon = inSeconds.remainder(60).toString().padLeft(2, '0');

    final result = <String>[];

    if (hours != '00') result.add('${hours}h');
    if (hours != '00' || minut != '00') result.add('${minut}m');
    result.add('${secon}s');

    return result.join(' ');
  }

  /// Result: '00:41:05'
  List<String> get toHourMinSegList {
    return [
      inHours,
      inMinutes.remainder(60),
      inSeconds.remainder(60),
    ].map((e) => e.toString().padLeft(2, '0')).toList();
  }

  /// Result: '41:05'
  String get toMinSec {
    return [
      inMinutes.remainder(60),
      inSeconds.remainder(60),
    ].map((e) => e.toString().padLeft(2, '0')).join(':');
  }

  /// Returns this Duration in a String formatted as 00:00.000 (min:sec.milli)
  String get toMinSecMilli {
    final values = [
      inMinutes.remainder(60),
      inSeconds.remainder(60),
      inMilliseconds.remainder(1000),
    ].map((e) => e.toString().padLeft(2, '0')).toList();

    return '${values[0]}:${values[1]}.${values[2].padLeft(3, '0')}';
  }

  /// Returns this Duration in a String formatted as 00:00s 000ms
  String get toMinSecMilliTxt {
    final values = [
      inMinutes.remainder(60),
      inSeconds.remainder(60),
      inMilliseconds.remainder(1000),
    ].map((e) => e.toString().padLeft(2, '0')).toList();

    var result = '';

    if (inMinutes == 0) {
      result = '$inSeconds.${values[2].substring(0, 1)}s';
    } else {
      result = '$inMinutes:${values[1]}';
    }
    return result;
  }
}
