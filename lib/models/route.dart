import 'package:pooly_task/models/money.dart';
import 'package:pooly_task/models/time.dart';

/// Routes that can be selected by the user, determined ahead
class Route {
  final String origin;
  final String destination;
  final Time time;
  final Duration eta;
  final Money cost;

  const Route(this.origin, this.destination, this.time, this.eta, this.cost);

  static const List<Route> routes = [
    Route(
      "Koç Üniversitesi Batı Kampüsü",
      "Zincirlikuyu Metrobüs",
      Time(hours: 19),
      Duration(minutes: 28),
      Money(26)
    ),
    Route(
      "Boğaziçi Üniversitesi Kuzey Kampüsü",
      "Beşiktaş Vapur İskelesi",
      Time(hours: 18),
      Duration(minutes: 26),
      Money(10)
    ),
    Route(
      "Sabancı Üniversitesi, Tuzla",
      "Kadıköy Vapur İskelesi",
      Time(hours: 20, minutes: 30),
      Duration(minutes: 45),
      Money(55)
    ),
    Route(
      "Yeditepe Üniversitesi, Kayışdağı",
      "Altunizade Metrobüs",
      Time(hours: 21),
      Duration(minutes: 19),
      Money(22)
    ),
    Route(
      "Özyeğin Üniversitesi, Nişantepe",
      "Ülker Sports Arena",
      Time(hours: 18, minutes: 30),
      Duration(minutes: 29),
      Money(37)
    ),
  ];

  @override
  String toString() {
    return origin + "-" + destination + " / " + time.toString();
  }
}