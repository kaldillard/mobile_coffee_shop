import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_coffee_shop/constants/colors.dart';
import 'package:mobile_coffee_shop/components/delivery/my_google_map_widget.dart';
import 'package:mobile_coffee_shop/components/delivery_driver_tile.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress/step_progress.dart';

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({
    super.key,
    required LatLng? currentPosition,
    required Completer<GoogleMapController> mapController,
    required LatLng kGooglePlex,
    required this.polylines,
  })  : _currentPosition = currentPosition,
        _mapController = mapController,
        _kGooglePlex = kGooglePlex;

  final LatLng? _currentPosition;
  final Completer<GoogleMapController> _mapController;
  final LatLng _kGooglePlex;
  final Map<PolylineId, Polyline> polylines;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(24),
        right: Radius.circular(24),
      ),
      maxHeight: 350,
      panel: Column(
        spacing: 10,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 5,
            width: 45,
            decoration: BoxDecoration(
                color: color04, borderRadius: BorderRadius.circular(16)),
          ),
          const Column(
            children: [
              Text(
                "10 minutes left",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Delivery to ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "John Doe",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ])),
            ],
          ),
          StepProgress(
            totalSteps: 5,
            visibilityOptions: StepProgressVisibilityOptions.lineOnly,
            onStepChanged: (currentIndex) {
              debugPrint('onStepChanged: $currentIndex');
            },
            onStepLineTapped: (index) {
              debugPrint('onStepLineTapped: $index');
            },
            currentStep: 3,
            theme: const StepProgressThemeData(
              stepLineSpacing: 6,
              defaultForegroundColor: color04,
              activeForegroundColor: progressColor,
              highlightCompletedSteps: true,
              stepLineStyle: StepLineStyle(
                lineThickness: 4,
                borderRadius: Radius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  border: Border.all(color: color04),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: color04),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(
                    Icons.delivery_dining,
                    color: color01,
                    size: 40,
                  ),
                ),
                title: const Text(
                  "Delivered your order",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                    "We will deliver your goods to you in the shortest possible time."),
              ),
            ),
          ),
          const DeliveryDriverTile(
              driversName: "Mark Wade", driversImage: "https://i.pravatar.cc/")
        ],
      ),
      body: _currentPosition == null
          ? const Center(
              child: Text("Loading..."),
            )
          : MyGoogleMap(
              mapController: _mapController,
              kGooglePlex: _kGooglePlex,
              currentPosition: _currentPosition,
              polylines: polylines),
    );
  }
}
