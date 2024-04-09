import 'package:mapbox_navigation/mapbox_navigation_platform_interface.dart';

class MapboxNavigation {
  Future<void> startNavigation(double start_lat, double start_lng, double end_lat, double end_lng) {
    return MapboxNavigationPlatform.instance
        .startNavigation(start_lat, start_lng, end_lat, end_lng);
  }
}
