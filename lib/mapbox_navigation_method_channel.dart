import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mapbox_navigation_platform_interface.dart';

/// An implementation of [MapboxNavigationPlatform] that uses method channels.
class MethodChannelMapboxNavigation extends MapboxNavigationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mapbox_navigation');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
