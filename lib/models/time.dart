class Time {
  final int hours;
  final int minutes;

  const Time({this.hours = 0, this.minutes = 0});

  @override
  String toString() {
    String hour = hours.toString();
    if (hour.length == 1) {
      hour = "0" + hour;
    }
    String minute = minutes.toString();
    if (minute.length == 1) {
      minute = "0" + minute;
    }
    return hour + ":" + minute;
  }

}