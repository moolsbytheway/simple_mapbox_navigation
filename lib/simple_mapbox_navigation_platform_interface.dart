import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'simple_mapbox_navigation_method_channel.dart';

abstract class MapboxNavigationPlatform extends PlatformInterface {
  /// Constructs a MapboxNavigationPlatform.
  MapboxNavigationPlatform() : super(token: _token);

  static final Object _token = Object();

  static MapboxNavigationPlatform _instance = MethodChannelMapboxNavigation();

  /// The default instance of [MapboxNavigationPlatform] to use.
  ///
  /// Defaults to [MethodChannelMapboxNavigation].
  static MapboxNavigationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapboxNavigationPlatform] when
  /// they register themselves.
  static set instance(MapboxNavigationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> startNavigation(double startLat, double  startLng, double  endLat, double endLng) {
    throw UnimplementedError('startNavigation() has not been implemented.');
  }
}
