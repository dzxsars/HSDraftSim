//
//  DZXStringKit.swift
//  SPDestiny
//
//  Created by DuZhiXia on 16/5/4.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class DZXStringKit {
    class func scanFirstIntInString(str:String)->Int32?{
        let scan = NSScanner(string: str)
        let numbers = NSCharacterSet(charactersInString: "0123456789")
        var found = false
        var hasInt:Int32 = 0
        while (!scan.atEnd) {
            scan.scanUpToCharactersFromSet(numbers, intoString: nil)
            if(scan.scanInt(&hasInt)){
                found = true
                break
            }
        }
        if(found){
            return hasInt
        }else{
            return nil
        }
    }
}
