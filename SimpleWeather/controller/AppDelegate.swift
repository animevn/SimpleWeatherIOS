import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)->Bool{
        print("app did load")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("app did become active")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       print("app will become inactive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("app did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       print("app will become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("app did terminate")
    }
}

