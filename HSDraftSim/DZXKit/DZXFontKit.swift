//
//  DZXFontKit.swift
//  SPDestiny
//
//  Created by DuZhiXia on 16/5/2.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class DZXFontKit {
    class func getSystemFontHeight(num:CGFloat)->CGFloat{
        let lbl = UILabel()
        lbl.text = "a啊@"
        let ft = UIFont.systemFontOfSize(num)
        lbl.font = ft
        lbl.sizeToFit()
        return lbl.frame.height
    }
    
    class func getSystemFontWithSize(num:CGFloat)->UIFont{
        let ft = UIFont.systemFontOfSize(num * DZXSystemKit.wRatio)
        return ft
    }
}