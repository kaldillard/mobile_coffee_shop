import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatelessWidget {
  const MyGoogleMap({
    super.key,
    required Completer<GoogleMapController> mapController,
    required LatLng kGooglePlex,
    required LatLng? currentPosition,
    required this.polylines,
  })  : _mapController = mapController,
        _kGooglePlex = kGooglePlex,
        _currentPosition = currentPosition;

  final Completer<GoogleMapController> _mapController;
  final LatLng _kGooglePlex;
  final LatLng? _currentPosition;
  final Map<PolylineId, Polyline> polylines;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) =>
          _mapController.complete(controller),
      initialCameraPosition: CameraPosition(
        target: _kGooglePlex,
        zoom: 12,
      ),
      markers: {
        Marker(
          markerId: const MarkerId(
            "_currentLocation",
          ),
          icon: AssetMapBitmap("/assets/Driver.png", width: 50, height: 50),
          position: _currentPosition!,
        ),
        Marker(
          markerId: const MarkerId(
            "_sourceLocation",
          ),
          icon: AssetMapBitmap("/assets/deliveryLocation.png",
              width: 50, height: 50),
          position: _kGooglePlex,
        ),
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
