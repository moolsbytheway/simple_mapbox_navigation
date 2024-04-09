import Flutter
import UIKit
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

public class MapboxNavigationPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "mapbox_navigation", binaryMessenger: registrar.messenger())
      let instance = MapboxNavigationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel);
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       switch call.method {
       case "startNavigation":
        if let args = call.arguments as? Dictionary<String, Any>,
            let start_lat = args["start_lat"] as? Double,
            let start_lng = args["start_lng"] as? Double,
            let end_lat = args["end_lat"] as? Double,
            let end_lng = args["end_lng"] as? Double {
             startNavigation(start_lat: start_lat, start_lng: start_lng, end_lat: end_lat, end_lng: end_lng)
               result(nil)
         } else {
               result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
         }
       default:
         result(FlutterMethodNotImplemented)
       }
     }
    
    
    private func startNavigation(start_lat: Double, start_lng: Double, end_lat: Double, end_lng: Double) {
        
        // Define two waypoints to travel between
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: start_lat, longitude: start_lng), name: "Start")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: end_lat, longitude: end_lng), name: "Target")

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
