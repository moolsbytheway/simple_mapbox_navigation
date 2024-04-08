
import 'package:mapbox_navigation/mapbox_navigation_platform_interface.dart';

class MapboxNavigation {
  Future<void> startActivity() {
    return MapboxNavigationPlatform.instance.startActivity();
  }
}
