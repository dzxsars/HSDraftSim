//
//  HSCardView.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/6.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit
import SnapKit

class HSCardView: UIView {
    
    var isDiscovered : Bool = false
    lazy var card : HSCard? = nil
    var delegate : HSCardViewProtocol?
    
    var bkg : UIView = UIView()
    var cardBack : UIImageView = UIImageView()
    var costLabel : UILabel = UILabel()
    var nameLabel : UILabel = UILabel()
    var mainImage : UIImageView = UIImageView()
    var rarityImage : UIImageView = UIImageView()
    var infoText : UITextView = UITextView()
    var attackLabel : UILabel = UILabel()
    var healthLabel : UILabel = UILabel()
    var typeLabel : UILabel = UILabel()
    var virtualBtn : UIButton = UIButton()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect,card:HSCard) {
        super.init(frame: frame)
        
        self.card = card
        
        bkg = UIView(frame: frame)
        bkg.backgroundColor = DZXColorKit.cellBkg
        
        cardBack = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height))
        cardBack.image = UIImage(named: "defaultCardBack")
//        cardBack.hidden = true
        bkg.addSubview(cardBack)
        
        costLabel = DZXUIKit.createLabel(NSNumber(integer:card.cost).stringValue, textColor: DZXColorKit.black, adjustWidth: 10, adjustHeight: 20, fontSize: nil)
        costLabel.textAlignment = .Center
        bkg.addSubview(costLabel)
        
//        nameLabel = DZXUIKit.createLabel(card.name, textColor: DZXColorKit.black, adjustWidth: nil, adjustHeight: nil, fontSize: 35)
        nameLabel = DZXUIKit.createLabel(card.name, textColor: DZXColorKit.black, adjustWidth: 60, adjustHeight: 30, fontSize: nil)
        nameLabel.textAlignment = .Center
        bkg.addSubview(nameLabel)
        
        mainImage = UIImageView()
        mainImage.backgroundColor = UIColor.whiteColor()
        bkg.addSubview(mainImage)
        
        rarityImage = UIImageView()
        switch card.rarity {
        case .LEGENDARY:
            rarityImage.image = DZXUIKit.createImageFromColor(UIColor.orangeColor(), size: CGSize(width: 10,height: 10))
        case .EPIC:
            rarityImage.image = DZXUIKit.createImageFromColor(UIColor.purpleColor(), size: CGSize(width: 10,height: 10))
        case .RARE:
            rarityImage.image = DZXUIKit.createImageFromColor(UIColor.blueColor(), size: CGSize(width: 10,height: 10))
        case .COMMON:
            rarityImage.image = DZXUIKit.createImageFromColor(UIColor.grayColor(), size: CGSize(width: 10,height: 10))
        default:
            break
        }
        bkg.addSubview(rarityImage)
        
//        infoLabel = DZXUIKit.createLabel(card.flavor, textColor: DZXColorKit.black, adjustWidth: nil, adjustHeight: nil, fontSize: 20)
        infoText = DZXUIKit.createTextView(DZXColorKit.black, backgroundColor: nil, editable: false, fontSize: 12, cornerRadius: nil, borderColor: nil, borderWidth: nil)
        infoText.text = card.flavor
        bkg.addSubview(infoText)
        
        if(card.attack != nil){
            attackLabel = DZXUIKit.createLabel(NSNumber(integer:card.attack!).stringValue, textColor: DZXColorKit.black, adjustWidth: 10, adjustHeight: 20, fontSize: nil)
        }
        attackLabel.textAlignment = .Center
        bkg.addSubview(attackLabel)
        
        if(card.health != nil){
            healthLabel = DZXUIKit.createLabel(NSNumber(integer:card.health!).stringValue, textColor: DZXColorKit.black, adjustWidth: 10, adjustHeight: 20, fontSize: nil)
        }
        healthLabel.textAlignment = .Center
        bkg.addSubview(healthLabel)
        
        var str = card.type.toText()
        if(str == "随从"){
            if(card.race != nil){
                str = card.race!.toText()
            }else{
                str = ""
            }
        }
        typeLabel = DZXUIKit.createLabel(str, textColor: DZXColorKit.black, adjustWidth: 30, adjustHeight: 20, fontSize: nil)
        typeLabel.textAlignment = .Center
        bkg.addSubview(typeLabel)
        
        virtualBtn = DZXUIKit.createButton(nil, textColor: nil, fontSize: nil, backgroundColor: nil, cornerRadius: nil, borderColor: nil, borderWidth: nil, target: self, action: #selector(self.btnIsClicked))
        bkg.addSubview(virtualBtn)
        
        self.addSubview(bkg)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true

        bkg.bringSubviewToFront(cardBack)
        bkg.bringSubviewToFront(virtualBtn)
        
        self.bringSubviewToFront(cardBack)
        self.bringSubviewToFront(virtualBtn)
        self.initializeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnIsClicked(){
        
        self.delegate?.cardIsClicked(self.isDiscovered,rarity:card!.rarity)
        if(!self.isDiscovered){
            self.isDiscovered = true
            cardBack.hidden = true
        }
    }

    
    ///初始化约束
    func initializeConstraints(){
        bkg.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        cardBack.snp_makeConstraints { (make) in
            make.edges.equalTo(bkg)
        }
        
        virtualBtn.snp_makeConstraints { (make) in
            make.edges.equalTo(bkg)
        }
        
        costLabel.snp_makeConstraints { (make) in
            make.left.equalTo(bkg).offset(10)
            make.top.equalTo(bkg).offset(10)
            make.height.equalTo(costLabel.frame.height)
            make.width.equalTo(costLabel.frame.width)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(bkg)
            make.top.equalTo(costLabel)
            make.bottom.equalTo(costLabel)
            make.width.equalTo(nameLabel.frame.width)
        }
        
        attackLabel.snp_makeConstraints { (make) in
            make.left.equalTo(bkg).offset(10)
            make.bottom.equalTo(bkg).offset(-10)
            make.height.equalTo(attackLabel.frame.height)
            make.width.equalTo(attackLabel.frame.width)
        }
        
        healthLabel.snp_makeConstraints { (make) in
            make.right.equalTo(bkg.snp_right).offset(-10)
            make.bottom.equalTo(bkg).offset(-10)
            make.height.equalTo(healthLabel.frame.height)
            make.width.equalTo(healthLabel.frame.width)
        }
        
        mainImage.snp_makeConstraints { (make) in
            make.top.equalTo(costLabel.snp_bottom).offset(10)
            make.bottom.equalTo(rarityImage.snp_top).offset(-10)
            make.left.equalTo(infoText)
            make.right.equalTo(infoText)
        }
        
        rarityImage.snp_makeConstraints { (make) in
            make.height.equalTo(10)
            make.centerX.equalTo(bkg)
            make.width.equalTo(10)
            make.bottom.greaterThanOrEqualTo(infoText.snp_top)
        }
        
        infoText.snp_makeConstraints { (make) in
            make.left.equalTo(bkg).offset(10)
            make.right.equalTo(bkg).offset(-10)
            make.height.equalTo(bkg).dividedBy(4)
            make.bottom.equalTo(typeLabel.snp_top).offset(-10)
        }
        
        typeLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(bkg)
            make.width.equalTo(typeLabel.frame.width)
            make.bottom.equalTo(bkg).offset(-10)
            make.height.equalTo(typeLabel.frame.height)
        }
        
        
    }




}

protocol HSCardViewProtocol {
    func cardIsClicked(discovered:Bool,rarity:HSRarity)
}
