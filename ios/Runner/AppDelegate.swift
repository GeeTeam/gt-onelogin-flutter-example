import UIKit
import Flutter
import OneLoginSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var oneLoginUtil: OneLoginUtil = OneLoginUtil()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    OneLogin.register(withAppID: "53cd718a9fd11e4dea99a22f138dc509")
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let oneLoginChannel = FlutterMethodChannel.init(name: "com.geetest.onelogin/onelogin", binaryMessenger: controller as! FlutterBinaryMessenger)
    oneLoginChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if "oneLogin" == call.method {
            let arg: NSNumber = call.arguments as! NSNumber
            if 0 == arg.intValue {
                self.normalLogin(controller: controller, result: result)
            } else if 1 == arg.intValue {
                self.popupLogin(controller: controller, result: result)
            } else if 2 == arg.intValue {
                self.floatWindowLogin(controller: controller, result: result)
            } else if 3 == arg.intValue {
                self.landscapeLogin(controller: controller, result: result)
            }
        }
    })
    
    OneLogin.preGetToken { ([AnyHashable : Any]) in
        
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func normalLogin(controller: UIViewController, result: @escaping FlutterResult) {
        oneLoginUtil.normalLogin(controller, flutterResult: result)
    }
    
    func popupLogin(controller: UIViewController, result: @escaping FlutterResult) {
        oneLoginUtil.popupLogin(controller, flutterResult: result)
    }
    
    func floatWindowLogin(controller: UIViewController, result: @escaping FlutterResult) {
        oneLoginUtil.floatWindowLogin(controller, flutterResult: result)
    }
    
    func landscapeLogin(controller: UIViewController, result: @escaping FlutterResult) {
        oneLoginUtil.landscapeLogin(controller, flutterResult: result)
    }
}

