import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Test());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = "Press the button to get your location";
  Location location = Location();

  Future<void> _getLocation() async {
    try {
      // Check if location service is enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() {
            _locationMessage = "Location services are disabled.";
          });
          return;
        }
      }

      // Check for permissions
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() {
            _locationMessage = "Location permissions are denied.";
          });
          return;
        }
      }

      // Get the current location
      LocationData locationData = await location.getLocation();

      // Update the location message with the fetched data
      setState(() {
        _locationMessage =
        "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}";
      });

      // Example: Send location data to an API (optional)
      await _sendLocationToApi(locationData.latitude, locationData.longitude);
    } catch (e) {
      setState(() {
        _locationMessage = "Error fetching location: $e";
      });
    }
  }

  Future<void> _sendLocationToApi(double? latitude, double? longitude) async {
    final url = Uri.parse('https://example.com/api/location'); // Replace with your API endpoint
    try {
      await http.post(url, body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });
    } catch (e) {
      print("Error sending location to API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
