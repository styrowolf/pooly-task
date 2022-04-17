import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pooly_task/models/route.dart' as PoolyRoute;

class MockedGeocodingApi {
  static List<List<LatLng>> latLngs = const [
    [LatLng(41.1944006,29.0485609), LatLng(41.067127,29.0110626)],
    [LatLng(41.0856436,29.0428853), LatLng(41.0410891,29.005159)],
    [LatLng(40.888534,29.3718013), LatLng(40.992824,29.0207913)],
    [LatLng(40.9745596,29.1517161), LatLng(41.023244,29.0420413)],
    [LatLng(41.034494,29.2542313), LatLng(40.992024,29.1032113)],
  ];
  static List<LatLng> getLatLng(PoolyRoute.Route route) {
    int i = PoolyRoute.Route.routes.indexOf(route);
    return latLngs[i];
  }
}