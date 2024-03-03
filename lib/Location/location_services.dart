import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Add this import statement

class LocationService {
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  Future<Coordinates> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show error or prompt user to enable
      throw LocationServiceDisabledException();
    }

    // Request permission to access location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission denied, request permission from user
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Location permission is permanently denied, show error or prompt user to grant permission from settings
        throw LocationPermissionDeniedForeverException();
      } else if (permission == LocationPermission.denied) {
        // Location permission denied, handle accordingly
        throw LocationPermissionDeniedException();
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return Coordinates(position.latitude, position.longitude);
  }

  Future<Coordinates> getCoordinatesFromAddress(String address) async {
    // Use geocoding to get coordinates from address
    List<Location> locations = await locationFromAddress(address); // Changed method to locationFromAddress
    Location location = locations.first;

    return Coordinates(location.latitude, location.longitude);
  }
}

class LocationServiceDisabledException implements Exception {
  final String message =
      'Location services are disabled. Please enable location services to use this feature.';
}

class LocationPermissionDeniedException implements Exception {
  final String message =
      'Location permission denied. Please grant permission to access your location.';
}

class LocationPermissionDeniedForeverException implements Exception {
  final String message =
      'Location permission permanently denied. Please grant permission from settings.';
}
