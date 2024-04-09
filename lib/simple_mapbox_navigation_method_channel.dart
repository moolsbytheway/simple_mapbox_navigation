import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'simple_mapbox_navigation_platform_interface.dart';

/// An implementation of [MapboxNavigationPlatform] that uses method channels.
class MethodChannelMapboxNavigation extends MapboxNavigationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('simple_mapbox_navigation');

  @override
  Future<void> startNavigation(double startLat, double startLng,
      double endLat, double endLng) async {
    await methodChannel
        .invokeMethod<String>('startNavigation', <String, dynamic>{
      "startLat": startLat,
      "startLng": startLng,
      "endLat": endLat,
      "endLng": endLng
    });
  }
}
