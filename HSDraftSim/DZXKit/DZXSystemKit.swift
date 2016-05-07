//
//  DZXSystemKit.swift
//  SPDestiny
//
//  Created by DuZhiXia on 16/5/2.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class DZXSystemKit {
    static let whRatio : CGFloat = DZXSystemKit.getWidthHeightRatio(DZXSystemKit.checkPhoneScreenType())
    static let width : CGFloat = UIScreen.mainScreen().bounds.width
    static let height : CGFloat = UIScreen.mainScreen().bounds.height
    static let UIWidth : CGFloat = 720
    static let UIHeight : CGFloat = 1080
    static let wRatio : CGFloat = width / UIWidth
    static let hRatio : CGFloat = height / UIHeight
    
    class func checkSystemVersion()->NSArray{
        let os = NSProcessInfo().operatingSystemVersion
        return [os.majorVersion,os.minorVersion,os.patchVersion]
    }
    
    class func checkPhoneScreenType()->String{
        if((UIScreen.mainScreen().bounds.width == 320)&&(UIScreen.mainScreen().bounds.height == 480)){
            return "ip4"
        }
        if((UIScreen.mainScreen().bounds.width == 320)&&(UIScreen.mainScreen().bounds.height == 568)){
            return "ip5"
        }
        if((UIScreen.mainScreen().bounds.width == 375)&&(UIScreen.mainScreen().bounds.height == 667)){
            return "ip6"
        }
        if((UIScreen.mainScreen().bounds.width == 414)&&(UIScreen.mainScreen().bounds.height == 736)){
            return "ip6p"
        }
        return "error"
    }
    
    class func getWidthHeightRatio(phoneScreenType:String)->CGFloat{
        switch phoneScreenType {
        case "ip4":
            return CGFloat(320) / CGFloat(480)
        case "ip5":
            return CGFloat(320) / CGFloat(568)
        case "ip6":
            return CGFloat(375) / CGFloat(667)
        case "ip6p":
            return CGFloat(414) / CGFloat(736)
        default:
            return 1.0
        }
    }
    
    class func sleepDoubleTime(time:Double,blockToExecute:dispatch_block_t){
        let t: NSTimeInterval = time
        let delay = dispatch_time(DISPATCH_TIME_NOW,Int64(t * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue(),blockToExecute)
    }

}



