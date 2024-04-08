import Flutter
import UIKit

public class MapboxNavigationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mapbox_navigation", binaryMessenger: registrar.messenger())
    let instance = MapboxNavigationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    private func startNavigation() {
      let rootViewController = UIApplication.shared.keyWindow?.rootViewController
      let viewController = ViewController()
      rootViewController?.present(viewController, animated: true, completion: nil)
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startActivity":
        startNavigation();
        result(nil)
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
}
