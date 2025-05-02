import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/delivery/delivery_info_widget.dart';
import 'package:mobile_coffee_shop/components/delivery/delivery_screen_row.dart';
import 'package:mobile_coffee_shop/constants/const.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  const DeliveryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends ConsumerState<DeliveryScreen> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _kGooglePlex = LatLng(37.4222, -122.0853);

  LatLng? _currentPosition;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    // .then(
    //   (_) => (

    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.sizeOf(context).width, 50),
          child: const SafeArea(
            child: DeliveryScreenRow(),
          )),
      body: DeliveryInfoWidget(
          currentPosition: _currentPosition,
          mapController: _mapController,
          kGooglePlex: _kGooglePlex,
          polylines: polylines),
    );
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCamerPosition = CameraPosition(
      target: position,
      zoom: 12,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCamerPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _cameraToPosition(_currentPosition!);

        getPolylinePoints(_currentPosition)
            .then((coordinates) => {generatePolylineFromPoints(coordinates)});
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints(currentPosition) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: GOOGLE_MAPS_API_KEY,
        request: PolylineRequest(
            origin: PointLatLng(_kGooglePlex.latitude, _kGooglePlex.longitude),
            destination: PointLatLng(
                currentPosition.latitude, currentPosition.longitude),
            mode: TravelMode.driving));
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      if (kDebugMode) {
        print(result.errorMessage);
      }
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: color01, points: polylineCoordinates, width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
