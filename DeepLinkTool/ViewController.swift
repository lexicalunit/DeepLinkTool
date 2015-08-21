import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var URLSchemeLabel: UILabel!
    @IBOutlet weak var QRCodeImageView: UIImageView!
    @IBOutlet weak var DeepLinkLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = NSBundle.mainBundle()
        let info = bundle.infoDictionary!
        let scheme = info["CFBundleURLTypes"]?[0]["CFBundleURLSchemes"]??[0] as? String
        URLSchemeLabel.text = "URL Scheme '\(scheme!)'"
        self.DeepLinkLabel.text = ""
    }

    func showDeepLink(deepLink: NSURL) {
        dispatch_async(dispatch_get_main_queue(), {
            self.showQRCode(deepLink.absoluteString!)
            self.DeepLinkLabel.text = deepLink.absoluteString!
        })
    }

    func showQRCode(str: NSString) {
        let data = str.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        let QRCodeImage = filter.outputImage
        let scaleX = QRCodeImageView.frame.size.width / QRCodeImage.extent().size.width
        let scaleY = QRCodeImageView.frame.size.height / QRCodeImage.extent().size.height
        let transformedImage = QRCodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        QRCodeImageView.image = UIImage(CIImage: transformedImage)
    }
}
