import 'package:intl/intl.dart';

class AppDateUtils {
  static String getGreeting([String name = 'Ajay']) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return '$greeting, $name 👋';
  }

  static String getTodayFormatted() {
    return DateFormat('EEEE, d MMMM').format(DateTime.now());
  }

  static String formatDate(DateTime date) {
    return DateFormat('d MMM yyyy').format(date);
  }
}
