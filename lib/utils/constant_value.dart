import 'package:intl/intl.dart';

class Constants {
  Constants._internal();
  static final Constants _instance = Constants._internal();
  factory Constants() => _instance;

  String dateFormat(String date) {
    String dateFormate = DateFormat("dd MMM yyyy").format(DateTime.parse(date));

    return dateFormate;
  }

  List<String> dropDownList = [
    "Jan 2023",
    "Feb 2023",
    "Mar 2023",
    "Apr 2023",
    "May 2023",
    "Jun 2023",
    "Jul 2023",
    "Aug 2023",
    "Sep 2023",
    "Oct 2023",
    "Nov 2023",
    "Dec 2023",
  ];

  List<String> dropDownNumberList = [
    "012023",
    "022023",
    "032023",
    "042023",
    "052023",
    "062023",
    "072023",
    "082023",
    "092023",
    "112023",
    "122023",
    "132023",
  ];
}
