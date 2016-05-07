//
//  DZXUIKit.swift
//  SPDestiny
//
//  Created by DuZhiXia on 16/5/2.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class DZXUIKit {
    class func createLabel(content:String?,textColor:UIColor?,adjustWidth:CGFloat?,adjustHeight:CGFloat?,fontSize:CGFloat?)->UILabel{
        let lbl = UILabel()
        lbl.text = content
        lbl.textColor = textColor
        if(adjustWidth != nil && adjustHeight != nil){
            lbl.frame = CGRectMake(0, 0, adjustWidth!, adjustHeight!)
            lbl.adjustsFontSizeToFitWidth = true
        }else if(fontSize != nil){
            lbl.font = DZXFontKit.getSystemFontWithSize(fontSize!)
            lbl.sizeToFit()
        }
        return lbl
    }
    
    class func createButton(title:String?,textColor:UIColor?,fontSize:CGFloat?,backgroundColor:UIColor?,cornerRadius:CGFloat?,borderColor:UIColor?,borderWidth:CGFloat?,target:AnyObject?, action:Selector?)->UIButton{
        let btn = UIButton()
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(textColor, forState: .Normal)
        btn.backgroundColor = backgroundColor
        if(cornerRadius != nil){
            btn.layer.cornerRadius = cornerRadius!
            btn.layer.masksToBounds = true
        }
        if(borderWidth != nil){
            btn.layer.borderColor = borderColor?.CGColor
            btn.layer.borderWidth = borderWidth!
        }
        if(action != nil){
            btn.addTarget(target, action: action!, forControlEvents: .TouchUpInside)
        }
        if(fontSize != nil){
            btn.titleLabel?.font = DZXFontKit.getSystemFontWithSize(fontSize!)
        }
        return btn
    }
    
    class func createTextField(placeholder:String?,textColor:UIColor?,fontSize:CGFloat?,cornerRadius:CGFloat?,borderColor:UIColor?,borderWidth:CGFloat?)->UITextField{
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = textColor
        if(cornerRadius != nil){
            tf.layer.cornerRadius = cornerRadius!
            tf.layer.masksToBounds = true
        }
        if(borderWidth != nil){
            tf.layer.borderColor = borderColor?.CGColor
            tf.layer.borderWidth = borderWidth!
        }
        if(fontSize != nil){
            tf.font = DZXFontKit.getSystemFontWithSize(fontSize!)
        }
        return tf
    }
    
    class func createTextView(textColor:UIColor?,backgroundColor:UIColor?,editable:Bool,fontSize:CGFloat?,cornerRadius:CGFloat?,borderColor:UIColor?,borderWidth:CGFloat?)->UITextView{
        let tf = UITextView()
        tf.textColor = textColor
        if(cornerRadius != nil){
            tf.layer.cornerRadius = cornerRadius!
            tf.layer.masksToBounds = true
        }
        tf.backgroundColor = backgroundColor
        tf.editable = editable
        if(borderWidth != nil){
            tf.layer.borderColor = borderColor?.CGColor
            tf.layer.borderWidth = borderWidth!
        }
        if(fontSize != nil){
            tf.font = DZXFontKit.getSystemFontWithSize(fontSize!)
        }
        return tf
    }
    
    class func createImageFromColor(color: UIColor,size: CGSize)->UIImage{
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        let rect = UIScreen.mainScreen().bounds
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension CGRect {
    init(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,ratio:Bool){
        var rw = DZXSystemKit.wRatio
        var rh = DZXSystemKit.hRatio
        if(!ratio){
            rw = 1
            rh = 1
        }
        self.init(x: x * rw, y: y * rh, width: width * rw, height: height * rh)
    }
}

extension Int {
    func wRatio()->CGFloat{
        return CGFloat(self) * DZXSystemKit.wRatio
    }
    
    func hRatio()->CGFloat{
        return CGFloat(self) * DZXSystemKit.hRatio
    }
}