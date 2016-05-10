//
//  HSDraftUtils.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/7.
//  Copyright © 2016年 geralt. All rights reserved.
//

import Foundation

class HSDraftUtils {
    static private let utilObject : HSDraftUtils = HSDraftUtils()
    
    
    private var OGLegendaryCards : NSArray = []
    private var OGEpicCards : NSArray = []
    private var OGRareCards : NSArray = []
    private var OGCommonCards : NSArray = []
    private var OGFreeCards : NSArray = []
    
    private var classicLegendaryCards : NSArray = []
    private var classicEpicCards : NSArray = []
    private var classicRareCards : NSArray = []
    private var classicCommonCards : NSArray = []
    private var classicFreeCards : NSArray = []
    
    private var TGTLegendaryCards : NSArray = []
    private var TGTEpicCards : NSArray = []
    private var TGTRareCards : NSArray = []
    private var TGTCommonCards : NSArray = []
    private var TGTFreeCards : NSArray = []
    
    private var druidCards : NSArray = []
    private var hunterCards : NSArray = []
    private var mageCards : NSArray = []
    private var paladinCards : NSArray = []
    private var priestCards : NSArray = []
    private var rogueCards : NSArray = []
    private var shamanCards : NSArray = []
    private var warlockCards : NSArray = []
    private var warriorCards : NSArray = []
    private var publicCards : NSArray = []
    
    //User Info
    private var userRemainPackages : Int = 60
    private var userCardDeck : NSMutableDictionary = NSMutableDictionary()
    private var userRemainCoin : Float = 388.0
    
    //File system
    private let plistName : String = "UserInfo.plist"
    private let _remainPackagesKey : String = "remainPackages"
    private let _cardDeckKey : String = "cardDeck"
    private let _remainCoinKey : String = "remainCoin"

    class func sharedInstance()->HSDraftUtils{
        return utilObject
    }
    
    private func loadJSONData(){
        let path = NSBundle.mainBundle().pathForResource("card", ofType: "json")
        if(path != nil){
            let url = NSURL(fileURLWithPath: path!)
            let nsData: NSData = NSData(contentsOfURL: url)!
            var json: AnyObject?
            do{
                json = try NSJSONSerialization.JSONObjectWithData(nsData, options: NSJSONReadingOptions.MutableContainers)
            }catch{
                print("json catch error")
            }
            let arr = json as? NSArray
            if(arr != nil){
                self.splitCardsByRarity(arr!)
            }
        }
    }
    
    private func splitCardsByRarity(allCards:NSArray){
        let ccommons = NSMutableArray()
        let crares = NSMutableArray()
        let cepics = NSMutableArray()
        let clegendaries = NSMutableArray()
        let cfrees = NSMutableArray()
        let tcommons = NSMutableArray()
        let trares = NSMutableArray()
        let tepics = NSMutableArray()
        let tlegendaries = NSMutableArray()
        let tfrees = NSMutableArray()
        let ocommons = NSMutableArray()
        let orares = NSMutableArray()
        let oepics = NSMutableArray()
        let olegendaries = NSMutableArray()
        let ofrees = NSMutableArray()
        
        let druid = NSMutableArray()
        let hunter = NSMutableArray()
        let mage = NSMutableArray()
        let paladin = NSMutableArray()
        let priest = NSMutableArray()
        let rogue = NSMutableArray()
        let shaman = NSMutableArray()
        let warlock = NSMutableArray()
        let warrior = NSMutableArray()
        let all = NSMutableArray()
        
        for item in allCards{
            var card : HSCard = HSCard(item:item as! NSDictionary)
            
            if(card.type == .HERO){
                continue
            }
            
            if(card.set == .GVG || card.set == .NAXX){
                continue
            }
            
            switch card.rarity {
            case .COMMON:
//                commons.addObject(card)
                switch card.set {
                case .EXPERT1:
                    addCardsToArray(ccommons,card: card)
                case .TGT:
                    addCardsToArray(tcommons,card: card)
                case .OG:
                    addCardsToArray(ocommons,card: card)
                default:
                    break
                }
            case .RARE:
//                rares.addObject(card)
                switch card.set {
                case .EXPERT1:
                    addCardsToArray(crares,card: card)
                case .TGT:
                    addCardsToArray(trares,card: card)
                case .OG:
                    addCardsToArray(orares,card: card)
                default:
                    break
                }
            case .EPIC:
//                epics.addObject(card)
                switch card.set {
                case .EXPERT1:
                    addCardsToArray(cepics,card: card)
                case .TGT:
                    addCardsToArray(tepics,card: card)
                case .OG:
                    addCardsToArray(oepics,card: card)
                default:
                    break
                }
            case .LEGENDARY:
//                legendaries.addObject(card)
                switch card.set {
                case .EXPERT1:
                    addCardsToArray(clegendaries,card: card)
                case .TGT:
                    addCardsToArray(tlegendaries,card: card)
                case .OG:
                    addCardsToArray(olegendaries,card: card)
                default:
                    break
                }
            case .FREE:
//                frees.addObject(card)
                switch card.set {
                case .EXPERT1:
                    addCardsToArray(cfrees,card: card)
                case .TGT:
                    addCardsToArray(tfrees,card: card)
                case .OG:
                    addCardsToArray(ofrees,card: card)
                default:
                    break
                }
            }
            
            
            if(card.playerClass != nil){
                switch card.playerClass! {
                case .DRUID:
//                    druid.addObject(card)
                    addCardsToArray(druid,card: card)
                case .HUNTER:
//                    hunter.addObject(card)
                    addCardsToArray(hunter,card: card)
                case .MAGE:
//                    mage.addObject(card)
                    addCardsToArray(mage,card: card)
                case .PALADIN:
//                    paladin.addObject(card)
                    addCardsToArray(paladin,card: card)
                case .PRIEST:
//                    priest.addObject(card)
                    addCardsToArray(priest,card: card)
                case .ROGUE:
//                    rogue.addObject(card)
                    addCardsToArray(rogue,card: card)
                case .SHAMAN:
//                    shaman.addObject(card)
                    addCardsToArray(shaman,card: card)
                case .WARLOCK:
//                    warlock.addObject(card)
                    addCardsToArray(warlock,card: card)
                case .WARRIOR:
//                    warrior.addObject(card)
                    addCardsToArray(warrior,card: card)
                case .ALL:
//                    all.addObject(card)
                    addCardsToArray(all,card: card)
                }
            }else{
                
            }
        }
        
        classicCommonCards = NSArray(array: ccommons)
        classicRareCards = NSArray(array: crares)
        classicEpicCards = NSArray(array: cepics)
        classicLegendaryCards = NSArray(array: clegendaries)
        classicFreeCards = NSArray(array: cfrees)
        
        TGTCommonCards = NSArray(array: tcommons)
        TGTRareCards = NSArray(array: trares)
        TGTEpicCards = NSArray(array: tepics)
        TGTLegendaryCards = NSArray(array: tlegendaries)
        TGTFreeCards = NSArray(array: tfrees)
        
        OGCommonCards = NSArray(array: ocommons)
        OGRareCards = NSArray(array: orares)
        OGEpicCards = NSArray(array: oepics)
        OGLegendaryCards = NSArray(array: olegendaries)
        OGFreeCards = NSArray(array: ofrees)

        
        druidCards = NSArray(array: druid)
        hunterCards = NSArray(array: hunter)
        mageCards = NSArray(array: mage)
        paladinCards = NSArray(array: paladin)
        priestCards = NSArray(array: priest)
        rogueCards = NSArray(array: rogue)
        shamanCards = NSArray(array: shaman)
        warlockCards = NSArray(array: warlock)
        warriorCards = NSArray(array: warrior)
        publicCards = NSArray(array: all)

        print(classicCommonCards.count + classicRareCards.count + classicEpicCards.count + classicLegendaryCards.count)
        print(TGTCommonCards.count + TGTRareCards.count + TGTEpicCards.count + TGTLegendaryCards.count)
        print(OGCommonCards.count + OGRareCards.count + OGEpicCards.count + OGLegendaryCards.count)
        print("\n")
        print(druidCards.count)
        print(hunterCards.count)
        print(mageCards.count)
        print(paladinCards.count)
        print(priestCards.count)
        print(rogueCards.count)
        print(shamanCards.count)
        print(warlockCards.count)
        print(warriorCards.count)
        print(publicCards.count)
    }
    
    ///卡组排序
    private func addCardsToArray(array:NSMutableArray,card:HSCard){
        if(array.count == 0){
            array.addObject(card)
            return
        }
        for i in 0...(array.count - 1){
            if(array[i].isKindOfClass(HSCard)){
                let c = array[i] as! HSCard
                if(card.isLessThan(c)){
                    array.insertObject(card, atIndex: i)
                    return
                }
            }else{
                return
            }
        }
        array.addObject(card)
    }
    
    /*
     username--
              |-remainPackages
              |-cardDeck
              |-remainCoin
    */
    ///初始化用户信息文件
    private func initUserInfo(){
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path : NSString = paths.objectAtIndex(0) as! NSString
        let filename : NSString = path.stringByAppendingPathComponent(plistName)
        
        let initialData : NSMutableDictionary = NSMutableDictionary()
        initialData.setObject(Int(0), forKey: _remainPackagesKey)
        initialData.setObject(NSMutableDictionary(), forKey: _cardDeckKey)
        initialData.setObject(Float(0.0), forKey: _remainCoinKey)
        
        initialData.writeToFile(filename as String, atomically: true)
    }
    
    ///运行后加载用户信息文件
    private func loadUserInfo(username:String)->Bool{
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path : NSString = paths.objectAtIndex(0) as! NSString
        let filename : NSString = path.stringByAppendingPathComponent(plistName)
        let data : NSMutableDictionary? = NSMutableDictionary(contentsOfFile: filename as String)
        if(data != nil){
            let aimData = data?.objectForKey(username) as? NSDictionary
            if(aimData != nil){
                userRemainPackages = aimData!.objectForKey(_remainPackagesKey)as! Int
                userCardDeck = aimData!.objectForKey(_remainCoinKey)as! NSMutableDictionary
                userRemainCoin = aimData!.objectForKey(_remainCoinKey)as! Float
                return true
            }else{
                return false
            }
        }else{
            initUserInfo()
            return true
        }
    }
    
    private func updateUserInfo(info:NSDictionary)->Bool{
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path : NSString = paths.objectAtIndex(0) as! NSString
        let filename : NSString = path.stringByAppendingPathComponent(plistName)
        let data : NSMutableDictionary? = NSMutableDictionary(contentsOfFile: filename as String)
        var allOK = true
        
        if(data != nil){
            for key in info.allKeys{
                let aimData = data?.objectForKey(key)
                if(aimData != nil){
                    switch key as! String {
                    case "remainPackages":
                        if((info.objectForKey(key)! as? Int) != nil){
                            data?.setObject(info.objectForKey(key)!, forKey: key as! String)
                        }else{
                            allOK = false
                        }
                    case "cardDeck":
                        if((info.objectForKey(key)! as? NSMutableDictionary) != nil){
                            data?.setObject(info.objectForKey(key)!, forKey: key as! String)
                        }else{
                            allOK = false
                        }
                    case "remainCoin":
                        if((info.objectForKey(key)! as? Float) != nil){
                            data?.setObject(info.objectForKey(key)!, forKey: key as! String)
                        }else{
                            allOK = false
                        }
                    default:
                        break
                    }
                }
            }
            return allOK
        }else{
            initUserInfo()
            return updateUserInfo(info)
        }
    }
    
    private func readUserInfo(key:String)->AnyObject?{
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path : NSString = paths.objectAtIndex(0) as! NSString
        let filename : NSString = path.stringByAppendingPathComponent(plistName)
        let data : NSMutableDictionary? = NSMutableDictionary(contentsOfFile: filename as String)
        
        if(data != nil){
            let aimData = data?.objectForKey(key)
            if(aimData != nil){
                switch key {
                case _remainPackagesKey:
                    if(aimData as? Int != nil){
                        return aimData as! Int
                    }
                case _cardDeckKey:
                    if(aimData as? NSMutableDictionary != nil){
                        return aimData as! NSMutableDictionary
                    }
                case _remainCoinKey:
                    if(aimData as? Float != nil){
                        return aimData as! Float
                    }
                default:
                    return nil
                }
                return nil
            }else{
                return nil
            }
        }else{
            initUserInfo()
            return loadUserInfo(key)
        }
    }
    
    func createOneNewPackage(set:HSCardSet)->NSArray?{
        if(self.userRemainPackages >= 1){
            self.userRemainPackages -= 1
            if(!updateUserInfo([_remainPackagesKey:self.userRemainPackages])){
                self.userRemainPackages += 1
                return nil
            }
            var commonCards : NSArray = []
            var rareCards : NSArray = []
            var epicCards : NSArray = []
            var legendaryCards : NSArray = []
            
            switch set {
            case .EXPERT1:
                commonCards = classicCommonCards
                rareCards = classicRareCards
                epicCards = classicEpicCards
                legendaryCards = classicLegendaryCards
            case .TGT:
                commonCards = TGTCommonCards
                rareCards = TGTRareCards
                epicCards = TGTEpicCards
                legendaryCards = TGTLegendaryCards
            case .OG:
                commonCards = OGCommonCards
                rareCards = OGRareCards
                epicCards = OGEpicCards
                legendaryCards = OGLegendaryCards
            default:
                return nil
            }
            
            let drafted = NSMutableArray()
            var rareDrafted = false
            for i in 0...4{
                if(i == 4 && !rareDrafted){
                    let r = arc4random() % 100 + 1
                    if(r == 1){//legendary
                        let lr = Int(arc4random() % UInt32(legendaryCards.count))
                        drafted.addObject(legendaryCards[lr])
                        rareDrafted = true
                    }else if(r >= 2 && r <= 5){//epic
                        let er = Int(arc4random() % UInt32(epicCards.count))
                        drafted.addObject(epicCards[er])
                        rareDrafted = true
                    }else{//rare
                        let rr = Int(arc4random() % UInt32(rareCards.count))
                        drafted.addObject(rareCards[rr])
                        rareDrafted = true
                    }
                }else{
                    let r = arc4random() % 100 + 1
                    if(r == 1){//legendary
                        let lr = Int(arc4random() % UInt32(legendaryCards.count))
                        drafted.addObject(legendaryCards[lr])
                        rareDrafted = true
                    }else if(r >= 2 && r <= 5){//epic
                        let er = Int(arc4random() % UInt32(epicCards.count))
                        drafted.addObject(epicCards[er])
                        rareDrafted = true
                    }else if(r >= 6 && r <= 25){//rare
                        let rr = Int(arc4random() % UInt32(rareCards.count))
                        drafted.addObject(rareCards[rr])
                        rareDrafted = true
                    }else{//common
                        let cr = Int(arc4random() % UInt32(commonCards.count))
                        drafted.addObject(commonCards[cr])
                    }
                }
            }
            return NSArray(array: drafted)
        }else{
            return nil
        }
    }
    
    func addCardsToCardDeck(cardNum:Int,num:Int,rarity:HSRarity)->Bool{
        var key = ""
        switch rarity {
        case .COMMON:
            key = "common"
        case .RARE:
            key = "rare"
        case .EPIC:
            key = "epic"
        case .LEGENDARY:
            key = "legendary"
        default:
            return false
        }
        if(userCardDeck.objectForKey(key)as? NSMutableDictionary != nil){
            if((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as? Int != nil){
                let newNum = ((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as! Int) + num
                (userCardDeck.objectForKey(key)as! NSMutableDictionary).setObject(newNum, forKey: "\(cardNum)")
            }else{
                (userCardDeck.objectForKey(key)as! NSMutableDictionary).setObject(num, forKey: "\(cardNum)")
            }
            updateUserInfo([_cardDeckKey:userCardDeck])
            return true
        }else{
            userCardDeck.setObject(NSMutableDictionary(), forKey: key)
            if((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as? Int != nil){
                let newNum = ((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as! Int) + num
                (userCardDeck.objectForKey(key)as! NSMutableDictionary).setObject(newNum, forKey: "\(cardNum)")
            }else{
                (userCardDeck.objectForKey(key)as! NSMutableDictionary).setObject(num, forKey: "\(cardNum)")
            }
            updateUserInfo([_cardDeckKey:userCardDeck])
            return true
        }
    }
    
    func removeCardsFromCardDeck(cardNum:Int,num:Int,rarity:HSRarity)->Bool{
        var key = ""
        switch rarity {
        case .COMMON:
            key = "common"
        case .RARE:
            key = "rare"
        case .EPIC:
            key = "epic"
        case .LEGENDARY:
            key = "legendary"
        default:
            return false
        }
        if(userCardDeck.objectForKey(key)as? NSMutableDictionary != nil){
            if((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as? Int != nil){
                let newNum = ((userCardDeck.objectForKey(key)as! NSMutableDictionary).objectForKey("\(cardNum)") as! Int) - num
                if(newNum >= 0){
                    (userCardDeck.objectForKey(key)as! NSMutableDictionary).setObject(newNum, forKey: "\(cardNum)")
                    updateUserInfo([_cardDeckKey:userCardDeck])
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }else{
            userCardDeck.setObject(NSMutableDictionary(), forKey: key)
            return false
        }
    }
    
    func readCardInfoFromAll(cardNum:Int,rarity:HSRarity,set:HSCardSet)->NSDictionary{
        var commonCards : NSArray = []
        var rareCards : NSArray = []
        var epicCards : NSArray = []
        var legendaryCards : NSArray = []
        var freeCards : NSArray = []
        switch set {
        case .EXPERT1:
            commonCards = classicCommonCards
            rareCards = classicRareCards
            epicCards = classicEpicCards
            legendaryCards = classicLegendaryCards
            freeCards = classicFreeCards
        case .TGT:
            commonCards = TGTCommonCards
            rareCards = TGTRareCards
            epicCards = TGTEpicCards
            legendaryCards = TGTLegendaryCards
            freeCards = TGTFreeCards
        case .OG:
            commonCards = OGCommonCards
            rareCards = OGRareCards
            epicCards = OGEpicCards
            legendaryCards = OGLegendaryCards
            freeCards = OGFreeCards
        default:
            return NSDictionary()
        }
        switch rarity {
        case .COMMON:
            return commonCards[cardNum] as! NSDictionary
        case .RARE:
            return rareCards[cardNum] as! NSDictionary
        case .EPIC:
            return epicCards[cardNum] as! NSDictionary
        case .LEGENDARY:
            return legendaryCards[cardNum] as! NSDictionary
        case .FREE:
            return freeCards[cardNum] as! NSDictionary
        }
    }
    
    //*********************************************//
    // MARK: - Internal Getter
    //*********************************************//
    func readByRarity(rarity:HSRarity,set:HSCardSet)->NSArray{
        var commonCards : NSArray = []
        var rareCards : NSArray = []
        var epicCards : NSArray = []
        var legendaryCards : NSArray = []
        var freeCards : NSArray = []
        switch set {
        case .EXPERT1:
            commonCards = classicCommonCards
            rareCards = classicRareCards
            epicCards = classicEpicCards
            legendaryCards = classicLegendaryCards
            freeCards = classicFreeCards
        case .TGT:
            commonCards = TGTCommonCards
            rareCards = TGTRareCards
            epicCards = TGTEpicCards
            legendaryCards = TGTLegendaryCards
            freeCards = TGTFreeCards
        case .OG:
            commonCards = OGCommonCards
            rareCards = OGRareCards
            epicCards = OGEpicCards
            legendaryCards = OGLegendaryCards
            freeCards = OGFreeCards
        default:
            return NSArray()
        }

        switch rarity {
        case .COMMON:
            return commonCards
        case .RARE:
            return rareCards
        case .EPIC:
            return epicCards
        case .LEGENDARY:
            return legendaryCards
        case .FREE:
            return freeCards
        }
    }
    
    internal func readByPlayerClass(playerClass:HSPlayerClass)->NSArray{
        switch playerClass {
        case .DRUID:
            return self.druidCards
        case .HUNTER:
            return self.hunterCards
        case .MAGE:
            return self.mageCards
        case .PALADIN:
            return self.paladinCards
        case .PRIEST:
            return self.priestCards
        case .ROGUE:
            return self.rogueCards
        case .SHAMAN:
            return self.shamanCards
        case .WARLOCK:
            return self.warlockCards
        case .WARRIOR:
            return self.warriorCards
        case .ALL:
            return self.publicCards
        }
    }
    
    internal func readUserRemainCardPackages()->Int{
        return self.userRemainPackages
    }
    
    internal func readUserRemainCoin()->Float{
        return self.userRemainCoin
    }
    
    internal func readUserCardDeck()->NSMutableDictionary{
        return self.userCardDeck
    }
    
    
    //*********************************************//
    // MARK: - Initial Data From JSON File
    //*********************************************//
    internal func initialDataFromJSONFile(){
        self.loadJSONData()
    }

}