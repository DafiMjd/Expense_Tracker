import 'package:intl/intl.dart';

class Formatter {
  static String formatMoney(double money) {
    String rp = 'Rp. ';

    if (money < 1000) {
      return rp + money.toStringAsFixed(0);
    } else {
      if (money >= 1000000000) {
        return '~';
      } else if (money >= 1000000) {
        money /= 1000000;
        return rp + money.toStringAsFixed(0) + ' M';
      } else if (money >= 1000) {
        money /= 1000;
        return rp + money.toStringAsFixed(0) + ' K';
      } else {
        return '~';
      }
    }
  }

  static String dateFormat(String date) {
    DateFormat format = DateFormat('EEE, d/M/y');

    print(date);

    return format.format(DateTime.parse(date));
  }

  static String getMonth(String date) {
    DateFormat format = DateFormat('MMM');

    return format.format(DateTime.parse(date));
  }

  static String dateFormatToInput(DateTime date) {
    DateFormat format = DateFormat('yyy-MM-dd');

    return format.format(date);
  }
}
