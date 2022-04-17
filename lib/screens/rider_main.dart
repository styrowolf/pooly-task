import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pooly_task/colors.dart';
import 'package:pooly_task/models/route.dart' as PoolyRoute;

class RiderMainScreen extends StatefulWidget {
  const RiderMainScreen({Key? key}): super(key: key);

  @override
  State<RiderMainScreen> createState() => _RiderMainScreenState();
}

class _RiderMainScreenState extends State<RiderMainScreen> {
  late GoogleMapController _controller;
  PoolyRoute.Route currentRoute = PoolyRoute.Route.routes[0];

  static CameraPosition istanbulPosition = const CameraPosition(target: LatLng(41.0082, 28.9784));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: PoolyColors.darkBlue[0],
              child: GoogleMap(
                initialCameraPosition: istanbulPosition,
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller; 
                  });
                },
              ),
            ),
          ),
          const Expanded(
            flex: 1, 
            child: RouteSelectionBar(),
          )
        ]
      ),
    );
  }
}

class RouteSelectionBar extends StatefulWidget {
  const RouteSelectionBar({Key? key}): super(key: key);

  @override
  State<RouteSelectionBar> createState() => _RouteSelectionBarState();
}

class _RouteSelectionBarState extends State<RouteSelectionBar> {
  PoolyRoute.Route? selectedRoute;
  RouteSelectionScreen screen = RouteSelectionScreen.routes;

  @override
  Widget build(BuildContext context) {
    if (screen == RouteSelectionScreen.routes) {
      return ListView.builder(
        itemCount: PoolyRoute.Route.routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(PoolyRoute.Route.routes[index].toString()),
            onTap: () {
              setState(() {
                selectedRoute = PoolyRoute.Route.routes[index];
                screen = RouteSelectionScreen.routeDetails;
              });
            },
          );
        }
      );
    } else if (screen == RouteSelectionScreen.routeDetails) {
      return Text("route details");
    } else {
      return Text("impossible to reach");
    }
  }  
}

enum RouteSelectionScreen {
  routes,
  routeDetails,
}