import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let calculatorChannel = FlutterMethodChannel(name: "flutter.dev.calculator",
                                                  binaryMessenger: controller.binaryMessenger)

      
      calculatorChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          
          if( call.method == "add"){
              result(self?.add(numbers: call.arguments as! Array<Int>))
          }else if (call.method == "subtract"){
              result(self?.subtract(numbers: call.arguments as! Array<Int>))
          }else if (call.method == "multiply"){
              result(self?.multiply(numbers: call.arguments as! Array<Int>))
          }else if (call.method == "divide"){
              result(self?.divide(numbers: call.arguments as! Array<Int>))
          }
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func  add(numbers: Array<Int>)->Int {
    return numbers[0]+numbers[1]
}
    private func  subtract(numbers: Array<Int>)->Int {
      return numbers[0]-numbers[1]
  }
    private func  multiply(numbers: Array<Int>)->Int {
      return numbers[0]*numbers[1]
  }
    private func  divide(numbers: Array<Int>)->Int {
      return numbers[0]/numbers[1]
  }
}


