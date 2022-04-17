extension PrettyPrint on Duration {
  String prettyPrint() {
    int totalMinutes = inMinutes;
    int minutes = totalMinutes % 60;
    int hours = totalMinutes ~/ 60;
    if (hours == 0) {
      return minutes.toString() + " dakika";
    } else {
      return hours.toString() + " saat, " + minutes.toString() + " dakika";
    }
  }
}