import 'package:simple_mapbox_navigation/simple_mapbox_navigation_platform_interface.dart';

class MapboxNavigation {
  Future<void> startNavigation(double startLat, double startLng, double endLat, double endLng) {
    return MapboxNavigationPlatform.instance
        .startNavigation(startLat, startLng, endLat, endLng);
  }
}
