import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';

final _sameDayTimeFormatter = DateFormat('HH:mm:ss');
final _sameWeekFormatter = DateFormat('EEEE HH:mm:ss');
final _sameMonthFormatter = DateFormat('dd日 HH:mm:ss');
final _fullFormatter = DateFormat('MM/dd HH:mm:ss');

extension TimeFormatEx on DateTime {
  String toHumanReadable() {
    final now = DateTime.now();
    if (isToday) {
      // 同一天
      return _sameDayTimeFormatter.format(this);
    } else if (now.firstDayOfWeek == firstDayOfWeek) {
      // 同一周
      return _sameWeekFormatter.format(this);
    } else if (isAtSameMonthAs(now)) {
      return _sameMonthFormatter.format(this);
    } else {
      return _fullFormatter.format(this);
    }
  }
}
