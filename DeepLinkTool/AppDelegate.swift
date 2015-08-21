import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        // copy deep link to paste board
        dispatch_async(dispatch_get_main_queue(), {
            let pasteBoard = UIPasteboard.generalPasteboard()
            pasteBoard.string = url.absoluteString
        })
        showDeepLink(url)
        return true
    }

    func showDeepLink(deepLink: NSURL) {
        dispatch_async(dispatch_get_main_queue(), {
            let vc = UIApplication.sharedApplication().keyWindow?.rootViewController as? ViewController
            vc?.showDeepLink(deepLink)
        })
    }
}

