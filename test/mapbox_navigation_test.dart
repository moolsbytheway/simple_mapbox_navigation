import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_navigation/mapbox_navigation.dart';
import 'package:mapbox_navigation/mapbox_navigation_platform_interface.dart';
import 'package:mapbox_navigation/mapbox_navigation_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapboxNavigationPlatform
    with MockPlatformInterfaceMixin
    implements MapboxNavigationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MapboxNavigationPlatform initialPlatform = MapboxNavigationPlatform.instance;

  test('$MethodChannelMapboxNavigation is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapboxNavigation>());
  });

  test('getPlatformVersion', () async {
    MapboxNavigation mapboxNavigationPlugin = MapboxNavigation();
    MockMapboxNavigationPlatform fakePlatform = MockMapboxNavigationPlatform();
    MapboxNavigationPlatform.instance = fakePlatform;

    expect(await mapboxNavigationPlugin.getPlatformVersion(), '42');
  });
}
