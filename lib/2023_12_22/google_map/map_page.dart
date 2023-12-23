import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationSettings _settings;
  final Completer<GoogleMapController> _controller;
  final Set<Polyline> _polylines;
  int _index;
  LatLng? _prevLatLng;
  CameraPosition? _currentLocation;

  _MapPageState()
      : _settings = const LocationSettings(),
        _controller = Completer(),
        _polylines = {},
        _index = 0;

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
    _tracePath();
  }

  Future<void> _initCurrentLocation() async {
    final Position position = await _determinePosition();
    setState(() {
      _currentLocation = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17.0,
      );
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _tracePath() {
    Geolocator.getPositionStream(locationSettings: _settings)
        .listen((final Position position) {
      _prevLatLng = _currentLocation?.target;
      _currentLocation = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17.0,
      );

      final Polyline polyline = Polyline(
        polylineId: PolylineId('${_index++}'),
        points: [
          _prevLatLng ?? _currentLocation!.target,
          _currentLocation!.target
        ],
        color: Colors.red,
        width: 3,
      );

      setState(() {
        _polylines.add(polyline);
      });

      _moveCameraPosition(_currentLocation!);
    });
  }

  Future<void> _moveCameraPosition(final CameraPosition newLocation) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(newLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation != null
          ? GoogleMap(
              mapType: MapType.normal,
              polylines: _polylines,
              initialCameraPosition: _currentLocation!,
              onMapCreated: (final GoogleMapController controller) {
                _controller.complete(controller);
              },
              zoomControlsEnabled: false,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
