
import 'mapbox_navigation_platform_interface.dart';

class MapboxNavigation {
  Future<String?> getPlatformVersion() {
    return MapboxNavigationPlatform.instance.getPlatformVersion();
  }
}
