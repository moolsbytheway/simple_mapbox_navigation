import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mapbox_navigation_platform_interface.dart';

/// An implementation of [MapboxNavigationPlatform] that uses method channels.
class MethodChannelMapboxNavigation extends MapboxNavigationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mapbox_navigation');

  @override
  Future<void> startNavigation(double start_lat, double start_lng,
      double end_lat, double end_lng) async {
    await methodChannel
        .invokeMethod<String>('startNavigation', <String, dynamic>{
      "start_lat": start_lat,
      "start_lng": start_lng,
      "end_lat": end_lat,
      "end_lng": end_lng
    });
  }
}
