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
    var race : HSMinionRace?
    
    ///随从牌
    init(name:String,flavor:String,rarity:HSRarity,cost:Int,type:HSCardType,attack:Int?,health:Int?/*,mechanics:[HSMinionAbility]?*/,race:HSMinionRace?,duration:Int?){
        self.name = name
        self.flavor = flavor
        self.rarity = rarity
        self.cost = cost
        self.type = type
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
    }
    
    override init(){
        self.attack = nil
        self.health = nil
        self.race = nil
        self.duration = nil
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
}
