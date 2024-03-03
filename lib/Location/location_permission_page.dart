import 'package:flutter/material.dart';
import 'location_services.dart'; // Assuming you've already implemented LocationService

class LocationPermissionWidget extends StatefulWidget {
  @override
  _LocationPermissionWidgetState createState() =>
      _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget> {
  final LocationService _locationService = LocationService();

  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    // Check if location services are enabled
    bool serviceEnabled = await _locationService.isLocationServiceEnabled();
    setState(() {
      _isLocationEnabled = serviceEnabled;
    });
  }

  Future<void> _handleLocationPermission(bool allow) async {
    if (allow) {
      // Handle allow location permission
      // You may show a prompt to enable location services
      // and navigate to the system location settings if needed
    } else {
      // Handle deny location permission
      // You may show a message or take other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Permission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLocationEnabled ? null : () => _handleLocationPermission(true),
              child: Text('Allow Location'),
            ),
            ElevatedButton(
              onPressed: _isLocationEnabled ? () => _handleLocationPermission(false) : null,
              child: Text('Disallow Location'),
            ),
          ],
        ),
      ),
    );
  }
}
