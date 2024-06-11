import 'package:intl/intl.dart';

class MyDateTime {
  static DateTime dateFormat(String time) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String timeDate(String time) {
    String t = '';
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    t = DateFormat('jm').format(dateTime).toString();
    return t;
  }

  static dateAndTime(String time) {
    String dat = '';
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final today = DateTime.now();
    final yesterday = DateTime.now().add(const Duration(days: -1));

    final t = DateTime(today.year, today.month, today.day);
    final y = DateTime(yesterday.year, yesterday.month, yesterday.day);

    final d = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if(d == t){
      dat = 'Today';

    }else if(d == y ){
      dat = 'Yesterday';
    }else if (dateTime.year == dateTime.day){
      dat = DateFormat.MMMd().format(dateTime).toString();
    }
    else{
      dat = DateFormat.yMMMd().format(dateTime).toString();
    }
    return dat;
  }
}
