import 'package:intl/intl.dart';

extension AppDateExtenstion on DateTime {
  String getDayOfWeekOrFormattedDate() {
    DateTime now = DateTime.now();

    if (year == now.year && month == now.month && day == now.day) {
      return 'Today'; // Return 'Today' if the date is today
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day) {
      return 'Yesterday'; // Return 'Yesterday' if the date is yesterday
    }

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday + 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (isAfter(startOfWeek) && isBefore(endOfWeek)) {
      return DateFormat('EEEE').format(this); // Return day of week
    } else {
      return DateFormat('dd MMM yyyy').format(this); // Return formatted date
    }
  }
}
