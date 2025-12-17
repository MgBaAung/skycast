import 'package:geolocator/geolocator.dart';

class LocationRepository {
  
  Future<bool> _isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    return true;
  }

  Future<void> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception(
          'Location permissions are denied. Please grant permission in settings.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permissions are permanently denied. Please enable them in your device settings.',
      );
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      if (await _isLocationServiceEnabled() == false) {
        throw Exception('Location services are disabled. Please enable GPS.');
      }

      await _checkAndRequestPermission();

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      return position;
    } on Exception catch (e) {
      throw Exception('Location Error: ${e.toString()}');
    }
  }
}
