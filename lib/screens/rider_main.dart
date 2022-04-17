import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pooly_task/colors.dart';
import 'package:pooly_task/mocks/mocked_geocoding_api.dart';
import 'package:pooly_task/models/route.dart' as PoolyRoute;
import 'package:pooly_task/extensions/duration_pretty_print.dart';
import 'package:pooly_task/extensions/currency_pretty_print.dart';

final StateProvider<Set<Marker>> markersProvider = StateProvider((ref) => Set<Marker>());
final StateProvider<Set<Polyline>> polylinesProvider = StateProvider((ref) => Set<Polyline>());

class RiderMainScreen extends ConsumerStatefulWidget {
  const RiderMainScreen({Key? key}): super(key: key);

  @override
  ConsumerState<RiderMainScreen> createState() => _RiderMainScreenState();
}

class _RiderMainScreenState extends ConsumerState<RiderMainScreen> {
  GoogleMapController? _controller;

  PoolyRoute.Route currentRoute = PoolyRoute.Route.routes[0];

  static CameraPosition istanbulPosition = const CameraPosition(target: LatLng(41.0082, 28.9784));

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = ref.watch(markersProvider);
    Set<Polyline> polylines = ref.watch(polylinesProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: PoolyColors.darkBlue[0],
              child: GoogleMap(
                markers: markers,
                polylines: polylines,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: istanbulPosition,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: RouteSelectionBar(controller: _controller,)
          ),
        ]
      ),
    );
  }
}

class RouteSelectionBar extends ConsumerStatefulWidget {
  final GoogleMapController? controller;
  const RouteSelectionBar({required this.controller, Key? key}): super(key: key);

  @override
  ConsumerState<RouteSelectionBar> createState() => _RouteSelectionBarState();
}

class _RouteSelectionBarState extends ConsumerState<RouteSelectionBar> {
  PoolyRoute.Route? selectedRoute;
  RouteSelectionScreen screen = RouteSelectionScreen.routes;
  int numberOfPeople = 1;

  @override
  Widget build(BuildContext context) {
    if (screen == RouteSelectionScreen.routes) {
      return Column(
        children: [
          const SizedBox(height: 16,),
          Text("Yolculuklar", style: Theme.of(context).textTheme.subtitle2,),
          const SizedBox(height: 16,),
          Expanded(
            child: ListView.builder(
              itemCount: PoolyRoute.Route.routes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(PoolyRoute.Route.routes[index].displayWithTime()),
                  onTap: () async {
                    selectedRoute = PoolyRoute.Route.routes[index];
                    screen = RouteSelectionScreen.routeDetails;
                    await drawRoute(ref);
                    setState((){});
                  },
                );
              }
            )
          )
        ]
      );
    } else if (screen == RouteSelectionScreen.routeDetails) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Yolculuk Detayları", style: Theme.of(context).textTheme.subtitle2,),),
            const SizedBox(height: 8,),
            Text("Kalkış: " + selectedRoute!.origin),
            const SizedBox(height: 8,),
            Text("Varış: " + selectedRoute!.destination),
            const SizedBox(height: 8,),
            Text("Kalkış zamanı: " + selectedRoute!.time.toString()),
            const SizedBox(height: 8,),
            Text("Tahmini varış süresi: " + selectedRoute!.eta.prettyPrint()),
            const SizedBox(height: 8,),
            Text(
              "Kişi başı ücret: " 
              + (selectedRoute!.cost.amount / numberOfPeople).toStringAsFixed(2) 
              + " " + selectedRoute!.cost.currency.prettyPrint()
            ),
            const SizedBox(height: 8,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("1 kişi"),
                    selected: numberOfPeople == 1,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          numberOfPeople = 1;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8,),
                  ChoiceChip(
                    label: const Text("2 kişi"),
                    selected: numberOfPeople == 2,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          numberOfPeople = 2;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8,),
                  ChoiceChip(
                    label: const Text("3 kişi"),
                    selected: numberOfPeople == 3,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          numberOfPeople = 3;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8,),
                  ChoiceChip(
                    label: const Text("4 kişi"),
                    selected: numberOfPeople == 4,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          numberOfPeople = 4;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text("Geri"),
                    onPressed: () {
                      resetRoute();
                      setState(() {
                        selectedRoute = null;
                        numberOfPeople = 1;
                        screen = RouteSelectionScreen.routes;
                      });
                    },
                  )
                ),
                const SizedBox(width: 8,),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text("Yolculuğa Kayıt"),
                    onPressed: () {},
                  )
                )
              ],
            )
          ]
        )
      );
    } else {
      return Text("impossible to reach");
    }
  }

  Future<void> drawRoute(WidgetRef ref) async {
    List<LatLng> latLng = MockedGeocodingApi.getLatLng(selectedRoute!);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      "AIzaSyCMdlr1fOFlQugnpL5ugmTHornpU1ZzHQE",
      PointLatLng(latLng[0].latitude, latLng[0].longitude),
      PointLatLng(latLng[1].latitude, latLng[1].longitude),
      travelMode: TravelMode.driving,
    );
    ref.read(markersProvider.state).state = {
      Marker(
       infoWindow: InfoWindow(title: selectedRoute!.origin),
       markerId: MarkerId(selectedRoute!.origin),
       position: latLng[0],
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
      ),

      Marker(
       infoWindow: InfoWindow(title: selectedRoute!.destination),
       markerId: MarkerId(selectedRoute!.destination),
       position: latLng[1],
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
      ),
    };

    List<LatLng> polylineCoordinates = List.from(result.points.map((e) => LatLng(e.latitude, e.longitude)));

    ref.read(polylinesProvider.state).state = {
      Polyline(
        polylineId: const PolylineId("route"),
        color: PoolyColors.lightBlue[0],
        points: polylineCoordinates,
        width: 8,
      )
    };
  }

  void resetRoute() {
    ref.read(markersProvider.state).state = {};
    ref.read(polylinesProvider.state).state = {};
  }
}

enum RouteSelectionScreen {
  routes,
  routeDetails,
}