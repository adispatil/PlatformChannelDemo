import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      // GET THE FLUTTER VIEW CONTROLLER FROM THE WINDOW
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      // SETUP BATTERY CHANNEL
      // THIS CHANNEL WILL HANDLE THE BATTERY LEVEL REQUESTS FROM FLUTTER
      let batteryChannel = FlutterMethodChannel(name: "com.example.platform_channel_demo/battery", binaryMessenger: controller.binaryMessenger)
      
      
      batteryChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
          
          if call.method == "getBatteryLevel" {
              self.getBatteryLevel(result: result)
          } else {
              result(FlutterMethodNotImplemented)
          }
      }
      
      
      // SETUP CALCULATOR CHANNEL
      // THIS CHANNEL WILL HANDLE THE CALCUALTOR OPERATIONS OR REQUESTS
      let calculatorChannel = FlutterMethodChannel(name: "com.example.platform_channel_demo/calculator", binaryMessenger: controller.binaryMessenger)
      
      calculatorChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          
          if call.method == "calculate" {
              // EXTRACT THE NUMBERS AND operation
              guard let args = call.arguments as? [String: Any],
                    let num1 = args["num1"] as? Double,
                    let num2 = args["num2"] as? Double,
                    let operation = args["operation"] as? String
              else {
                  result(FlutterError(code: "INVALID_ARGUMENT",
                                      message: "Invalid arguments passed to calculate method.", details: nil))
                  return
              }
              
              
              let calculatedResult: Double
              switch operation {
              case "+":
                  calculatedResult = (num1 + num2) * 0.20
              case "-":
                  calculatedResult = num1 - num2
              default:
                  calculatedResult = 0.0
              }
              
              // SEND THE RESULT BACK TO FLUTTER
              result(calculatedResult)
          } else {
              result(FlutterMethodNotImplemented)
          }
      }
      
    // REGISTER FLUTTER PLUGINS
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    // HELPER METHOD TO GET THE BATTERY LEVEL
    private func getBatteryLevel(result: @escaping FlutterResult) {
        
        let device = UIDevice.current
        
        // ENABLE THE BATTERY MONITORING
        device.isBatteryMonitoringEnabled = true
        
        // CHECK BATTERY LEVEL STATE IS AVAILABLE
        if device.batteryState == .unknown{
            // RETURN ERROR IF BATTERY STATE IS UNKNOWN
            result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: nil))
        } else {
            // CONVERT BATTERY LEVEL TO PERCENTAGE(0-100%)
            result(Int(device.batteryLevel * 100))
        }
    }
}
