import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LocationData? _currentLocation;
  Set<Marker> _markers = {};
  Polyline? _polyline;
  List<LatLng> _polylineCoordinates = [];
  bool _isLoadingLocation = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.983617, 21.464940), // Default location
    zoom: 14.4746,
  );

  Future<void> _getUserLocation() async {
    setState(() {
      _isLoadingLocation = true; // Show loading state
    });

    Location location = Location();

    try {
      // Check if location services are enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception("Location services are disabled.");
        }
      }

      // Check for location permissions
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception("Location permissions are denied.");
        }
      }

      // Get current location
      _currentLocation = await location.getLocation();
      setState(() {
        _isLoadingLocation = false;
      });
      await _goToMyLocation(); // Move the camera to the user's location
    } catch (e) {
      setState(() {
        _isLoadingLocation = false; // Hide loading state
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _goToMyLocation() async {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to fetch location")),
      );
      return;
    }

    final GoogleMapController controller = await _controller.future;
    final CameraPosition position = CameraPosition(
      target: LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      ),
      zoom: 14.4746,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<void> _getRoute(LatLng destination) async {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to fetch location")),
      );
      return;
    }

    final String origin = '${_currentLocation!.latitude},${_currentLocation!.longitude}';
    final String destinationStr = '${destination.latitude},${destination.longitude}';
    final String apiKey = 'AIzaSyANPDAjUUBC3p7I1BvWWnjhZuo3sH8oIjI';

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destinationStr&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final route = data['routes'][0]['legs'][0];

        // Get polyline points
        final steps = route['steps'];
        _polylineCoordinates.clear();
        for (var step in steps) {
          final latLng = LatLng(step['end_location']['lat'], step['end_location']['lng']);
          _polylineCoordinates.add(latLng);
        }

        setState(() {
          _polyline = Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 6,
            points: _polylineCoordinates,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No route found")),
        );
      }
    } else {
      throw Exception('Failed to load directions');
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = _currentLocation == null
        ? _kGooglePlex // Show default location until the current location is fetched
        : CameraPosition(
      target: LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      ),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // Disable the default button
            markers: _markers,
            polylines: _polyline != null ? {_polyline!} : {},
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng destination) {
              // When tapping on the map, add a marker and get the route
              setState(() {
                _markers.clear();
                _markers.add(Marker(
                  markerId: MarkerId('destination'),
                  position: destination,
                  infoWindow: InfoWindow(title: 'Destination'),
                ));
              });

              // Get the route from current location to clicked location
              _getRoute(destination);
            },
          ),
          if (_isLoadingLocation)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getUserLocation,
        label: const Text('Get User Location'),
        icon: const Icon(Icons.my_location),
      ),
    );
  }
}
