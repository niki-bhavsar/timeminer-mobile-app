import 'package:intl/intl.dart';

class IntlUtil {
  /// date format = 04/24/1992
  static DateTime? parseDate(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      //07/09/1992
      DateFormat format = DateFormat("MM/dd/yyyy");
      return format.parse(date);
    } catch (ex) {
      return null;
    }
  }

  /// date format =  April
  static String? getMonth(DateTime? datetime) {
    if (datetime == null) return null;
    DateFormat format = DateFormat("MMM");
    return format.format(datetime);
  }

  //date format  = 01-31 // date only
  static String? getDate(DateTime? datetime) {
    if (datetime == null) return null;
    DateFormat format = DateFormat("dd");
    return format.format(datetime);
  }

  //date format  = 01/31/2024 // date only
  static String? getFullDate(DateTime? datetime, {String dateFormat = "MM/dd/yyyy"}) {
    if (datetime == null) return null;
    DateFormat format = DateFormat(dateFormat);
    return format.format(datetime);
  }
}
