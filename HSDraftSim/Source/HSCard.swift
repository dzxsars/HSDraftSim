//
//  HSCard.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/6.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class HSCard : NSObject{
    var name : String = ""
    var flavor : String = ""
    var rarity : HSRarity = .COMMON
    var cost : Int = 1
    var type : HSCardType = .MINION
    var attack : Int?
    var health : Int?
    var duration : Int?
//    var mechanics : [HSMinionAbility]?
    var race : HSMinionRace? = nil
    var playerClass : HSPlayerClass? = nil
    
    var id : String = ""
    var set : HSCardSet = .CORE
    var dust : NSArray? = [40,400,5,50]
    var texture : String = ""
    var howToEarn : String? = ""
    var howToEarnGolden : String? = ""
    var collectible : Bool = true
    var mechanics : NSArray? = []
    
    init(name:String,flavor:String,rarity:HSRarity,cost:Int,type:HSCardType,attack:Int?,health:Int?/*,mechanics:[HSMinionAbility]?*/,race:HSMinionRace?,duration:Int?,playerClass:HSPlayerClass?,id:String,set:HSCardSet,dust:NSArray?,texture:String,howToEarn:String?,howToEarnGolden:String?,collectible:Bool,mechanics:NSArray?){
        self.name = name
        self.flavor = flavor
        self.rarity = rarity
        self.cost = cost
        self.type = type
        self.playerClass = playerClass
        if(type == .MINION){
            self.attack = attack
            self.health = health
            self.race = race
            self.duration = nil
        }else if(type == .SPELL){
            self.attack = nil
            self.health = nil
            self.race = nil
            self.duration = nil
        }else if(type == .WEAPON){
            self.attack = attack
            self.health = nil
            self.race = nil
            self.duration = duration
        }
        
        self.id = id
        self.set = set
        self.dust = dust
        self.texture = texture
        self.howToEarn = howToEarn
        self.howToEarnGolden = howToEarnGolden
        self.collectible = collectible
        self.mechanics = mechanics
    }
    
    init(card:HSCard){
        self.name = card.name
        self.flavor = card.flavor
        self.rarity = card.rarity
        self.cost = card.cost
        self.type = card.type
        self.playerClass = card.playerClass
        if(type == .MINION){
            self.attack = card.attack
            self.health = card.health
            self.race = card.race
            self.duration = nil
        }else if(type == .SPELL){
            self.attack = nil
            self.health = nil
            self.race = nil
            self.duration = nil
        }else if(type == .WEAPON){
            self.attack = card.attack
            self.health = nil
            self.race = nil
            self.duration = card.duration
        }
        
        self.id = card.id
        self.set = card.set
        self.dust = card.dust
        self.texture = card.texture
        self.howToEarn = card.howToEarn
        self.howToEarnGolden = card.howToEarnGolden
        self.collectible = card.collectible
        self.mechanics = card.mechanics
    }
    
    convenience init(item:NSDictionary){
        //卡牌种类
        let type : String = item.objectForKey("type")as! String
        var ftype : HSCardType = .MINION
        if(type == "MINION"){
            ftype = .MINION
            
            
            /*
             mechanics = (item as! NSDictionary).objectForKey("mechanics")as? NSArray
             if(mechanics != nil){
             for ability in mechanics!{
             let str = ability as! String
             switch str {
             case "CHARGE":
             case "TAUNT":
             case "STEATH":
             case "COMBO":
             case "BATTLECRY":
             case "WINDFURY":
             case "ENRAGE":
             case "DIVINESHIELD":
             case "SPELLPOWER":
             case "OVERLOAD":
             case "INSPIRE":
             fMechanics.addObject(HSMinionAbility.Taunt.rawValue)
             case ""
             default:
             break
             }
             }
             */
        }else if(type == "SPELL"){
            ftype = .SPELL
        }else if(type == "WEAPON"){
            ftype = .WEAPON
        }else if(type == "HERO"){
            ftype = .HERO
        }
        
        //稀有度
        let rarity : String = item.objectForKey("rarity")as! String
        var frarity : HSRarity = .COMMON
        switch rarity {
        case "LEGENDARY":
            frarity = .LEGENDARY
        case "EPIC":
            frarity = .EPIC
        case "RARE":
            frarity = .RARE
        case "COMMON":
            frarity = .COMMON
        case "FREE":
            frarity = .FREE
        default:
            break
        }
        
        //名字
        let name : String = item.objectForKey("name")as! String
        
        //卡牌描述
        var flavor : String
        if(item.objectForKey("text")as? String != nil){
            var str = item.objectForKey("text")as! NSString
            str = str.stringByReplacingOccurrencesOfString("<b>", withString: "")
            str = str.stringByReplacingOccurrencesOfString("</b>", withString: "")
            str = str.stringByReplacingOccurrencesOfString("<i>", withString: "")
            str = str.stringByReplacingOccurrencesOfString("</i>", withString: "")
            str = str.stringByReplacingOccurrencesOfString("$", withString: "")
            str =  str.stringByReplacingOccurrencesOfString("#", withString: "")
            str =  str.stringByReplacingOccurrencesOfString("\n", withString: "")
            flavor = str as String
        }else{
            flavor = ""
        }
        
        
        //消耗费用
        var cost : Int
        if(item.objectForKey("cost")as? Int != nil){
            cost = item.objectForKey("cost")as! Int
        }else{
            cost = -1
        }
        
        //武器耐久度
        let duration : Int? = item.objectForKey("durability")as? Int
        
        //种族
        var race : String?
        var frace : HSMinionRace? = nil
        race = item.objectForKey("race")as? String
        if(race != nil){
            switch race! {
            case "MURLOC":
                frace = .MURLOC
            case "BEAST":
                frace = .BEAST
            case "DRAGON":
                frace = .DRAGON
            case "MACHINERY":
                frace = .MECHANICAL
            case "DEMON":
                frace = .DEMON
            case "PIRATE":
                frace = .PIRATE
            case "TOTEM":
                frace = .TOTEM
            default:
                break
            }
        }else{
            frace = nil
        }
        
        //随从或武器攻击力
        var attack : Int?
        attack = item.objectForKey("attack")as? Int
        
        //随从生命值
        var health : Int?
        health = item.objectForKey("health")as? Int
        
        //职业
        let playerClass : String? = item.objectForKey("playerClass")as? String
        var fplayerClass : HSPlayerClass?
        if(playerClass != nil){
            switch playerClass! {
            case HSPlayerClass.DRUID.toText():
                fplayerClass = .DRUID
            case HSPlayerClass.HUNTER.toText():
                fplayerClass = .HUNTER
            case HSPlayerClass.MAGE.toText():
                fplayerClass = .MAGE
            case HSPlayerClass.PALADIN.toText():
                fplayerClass = .PALADIN
            case HSPlayerClass.PRIEST.toText():
                fplayerClass = .PRIEST
            case HSPlayerClass.ROGUE.toText():
                fplayerClass = .ROGUE
            case HSPlayerClass.SHAMAN.toText():
                fplayerClass = .SHAMAN
            case HSPlayerClass.WARLOCK.toText():
                fplayerClass = .WARLOCK
            case HSPlayerClass.WARRIOR.toText():
                fplayerClass = .WARRIOR
            default:
                break
            }
        }else{
            fplayerClass = .ALL
        }
        
        //id
        let id : String = item.objectForKey("id")as! String
        let set : String = item.objectForKey("set")as! String
        var fset : HSCardSet
        switch set {
        case "CORE":
            fset = .CORE
        case "EXPERT1":
            fset = .EXPERT1
        case "NAXX":
            fset = .NAXX
        case "GVG":
            fset = .GVG
        case "BRM":
            fset = .BRM
        case "TGT":
            fset = .TGT
        case "LOE":
            fset = .LOE
        case "PROMO":
            fset = .PROMO
        case "REWARD":
            fset = .REWARD
        case "OG":
            fset = .OG
        default:
            fset = .CORE
        }
        let dust : NSArray? = item.objectForKey("dust")as? NSArray
        let texture : String = item.objectForKey("texture")as! String
        let howToEarn : String? = item.objectForKey("howToEarn")as? String
        let howToEarnGolden : String? = item.objectForKey("howToEarnGolden")as? String
        let collectible : Bool = item.objectForKey("collectible")as! Bool
        let mechanics : NSArray? = item.objectForKey("mechanics")as? NSArray
        self.init(name: name,flavor:flavor,rarity:frarity,cost:cost,type:ftype,attack:attack,health:health,race:frace,duration:duration,playerClass:fplayerClass,id:id,set:fset,dust:dust,texture:texture,howToEarn:howToEarn,howToEarnGolden:howToEarnGolden,collectible:collectible,mechanics:mechanics)
        
        
//        self.init(name: name, flavor: flavor, rarity: frarity, cost: cost, type: ftype, attack: attack, health: health, race: frace, duration: duration, playerClass: fplayerClass)
    }
    
    override init(){
        self.attack = nil
        self.health = nil
        self.race = nil
        self.duration = nil
    }
    
    func isLessThan(card:HSCard)->Bool{
        /*
         比较顺序:费用 / 类型 {(随从: 攻击 / 血量) / (武器: 攻击 / 耐久) / (法术)}
         */
        if(self.cost != card.cost){
            return self.cost < card.cost
        }else if(self.type != card.type){
            return self.type.compareWeight() < card.type.compareWeight()
        }else{
            switch self.type {
            case .HERO:
                return true
            case .MINION:
                if(self.attack! != card.attack!){
                    return self.attack! < card.attack!
                }else if(self.health! != card.health!){
                    return self.health! < card.health!
                }else{
                    return false
                }
            case .SPELL:
                return true
            case .WEAPON:
                if(self.attack! != card.attack!){
                    return self.attack! < card.attack!
                }else if(self.duration! != card.duration!){
                    return self.duration! < card.duration!
                }else{
                    return false
                }
            }
        }
    }

}

enum HSMinionAbility : Int {
    case Charge = 0
    case Taunt
    case Stealth
    case Combo
    case Battlecry
    case Windfury
    case Enraged
    case DeathRattle
    case DivineShield
    case SpellPower
    case Overload
    case Inspire
    case Freeze
    case ChooseOne
    case Aura
    case AdjacentBuff
}

enum HSMinionRace : Int {
    case MURLOC = 0
    case BEAST
    case DRAGON
    case MECHANICAL
    case DEMON
    case PIRATE
    case TOTEM
    
    func toText() -> String {
        switch self {
        case .MURLOC:
            return "鱼人"
        case .BEAST:
            return "野兽"
        case .DRAGON:
            return "龙"
        case .MECHANICAL:
            return "机械"
        case .DEMON:
            return "恶魔"
        case .PIRATE:
            return "海盗"
        case .TOTEM:
            return "图腾"
        }
    }
}

enum HSRarity {
    case LEGENDARY
    case EPIC
    case RARE
    case COMMON
    case FREE
}

enum HSCardType : Int {
    case MINION = 0
    case SPELL
    case WEAPON
    case HERO
    
    func toText() -> String {
        switch self {
        case .MINION:
            return "随从"
        case .SPELL:
            return "法术"
        case .WEAPON:
            return "武器"
        case .HERO:
            return "英雄"
        }
    }
    
    func compareWeight() -> Int{
        switch self {
        case .MINION:
            return 4
        case .SPELL:
            return 2
        case .WEAPON:
            return 3
        case .HERO:
            return 1
        }
    }
}

enum HSCardSet : Int {
    case CORE = 0
    case EXPERT1
    case NAXX
    case GVG
    case BRM
    case TGT
    case LOE
    case PROMO
    case REWARD
    case OG
    
    /*
    func toSet() -> String {
        switch self {
        case .CORE:
            return "CS2"
        case .EXPERT1:
            return "NEW1"
        case .NAXX:
            return ""
        case .GVG:
            return ""
        case .BRM:
            return ""
        case .TGT:
            return ""
        case .LOE:
            return ""
        case .PROMO:
            return ""
        case .REWARD:
            return ""

        }
    }
    */
}

enum HSPlayerClass : Int {
    case DRUID = 0
    case HUNTER
    case MAGE
    case PALADIN
    case PRIEST
    case ROGUE
    case SHAMAN
    case WARLOCK
    case WARRIOR
    case ALL
    
    func toText()->String{
        switch self {
        case .DRUID:
            return "DRUID"
        case .HUNTER:
            return "HUNTER"
        case .MAGE:
            return "MAGE"
        case .PALADIN:
            return "PALADIN"
        case .PRIEST:
            return "PRIEST"
        case .ROGUE:
            return "ROGUE"
        case .SHAMAN:
            return "SHAMAN"
        case .WARLOCK:
            return "WARLOCK"
        case .WARRIOR:
            return "WARRIOR"
        case .ALL:
            return "ALL"
        }
    }
}
