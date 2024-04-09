import Flutter
import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

public class SimpleMapboxNavigationPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "simple_mapbox_navigation", binaryMessenger: registrar.messenger())
      let instance = SimpleMapboxNavigationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel);
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       switch call.method {
       case "startNavigation":
        if let args = call.arguments as? Dictionary<String, Any>,
            let startLat = args["startLat"] as? Double,
            let startLng = args["startLng"] as? Double,
            let endLat = args["endLat"] as? Double,
            let endLng = args["endLng"] as? Double {
             startNavigation(startLat: startLat, startLng: startLng, endLat: endLat, endLng: endLng)
               result(nil)
         } else {
               result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
         }
       default:
         result(FlutterMethodNotImplemented)
       }
     }
    
    
    private func startNavigation(startLat: Double, startLng: Double, endLat: Double, endLng: Double) {
        
        // Define two waypoints to travel between
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: startLat, longitude: startLng), name: "Start")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: endLat, longitude: endLng), name: "Target")

        // Set options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        let navigationOptions = NavigationOptions(simulationMode: .never)

        // Request a route using MapboxDirections.swift
        Directions.shared.calculate(routeOptions) { (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                // Pass the first generated route to the the NavigationViewController
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController;
                
                guard let rootViewGuard = rootViewController else { return }
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions, navigationOptions: navigationOptions);
                viewController.modalPresentationStyle = .fullScreen
                rootViewGuard.present(viewController, animated: true, completion: nil)
            }
        }

    }
    
}
