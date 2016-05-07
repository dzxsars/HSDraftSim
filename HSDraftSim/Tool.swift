
import UIKit

class Tool:NSObject
{
    class func dismissHUD()
    {
        ProgressHUD.dismiss()
    }
    
    
    class func showProgressHUD(text:String)
    {
        ProgressHUD.show(text, interaction: false)
    }
    
    class func showSuccessHUD(text:String)
    {
        ProgressHUD.showSuccess(text)
    }
    
    class func showErrorHUD(text:String)
    {
        ProgressHUD.showError(text)
    }
    
    class func showCustomHUD(text:String, image: UIImage,interactive: Bool, delayTime: NSTimeInterval)
    {
        ProgressHUD.showCustom(text, withImage: image, interaction: interactive)
        NSTimer.scheduledTimerWithTimeInterval(delayTime, target: Tool.self, selector: "dismissHUD", userInfo: nil, repeats: false)
    }

    
    
    
    
    
}