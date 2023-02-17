import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat.yMMMMd("en_US").format(date);
  }

  static String formatFirstAirDate(String date) {
    try {
      var formatter = DateFormat('MMMM dd, yyyy');
      return formatter.format(DateTime.parse(date));
    } catch (e) {
      if (date.isEmpty) {
        return "series not aired yet";
      } else {
        return "Date incorrect format";
      }
    }
  }
}
