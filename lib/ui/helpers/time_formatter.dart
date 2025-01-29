import 'package:intl/intl.dart';

class TimeFormatter {
  static final _formatterWithMinutes = DateFormat('mm:ss.SSS');
  static final _formatterWithoutMinutes = DateFormat('ss.SSS');

  static String format(dynamic duration) {
    if (duration == null) return '';
    if (duration is String) return duration;

    final durationMs = Duration(milliseconds: (duration * 1000).toInt());
    final dateTime = DateTime(0, 0, 0, 0, 0, 0, durationMs.inMilliseconds);

    return durationMs.inMinutes > 0
        ? _formatterWithMinutes.format(dateTime)
        : _formatterWithoutMinutes.format(dateTime);
  }
}
