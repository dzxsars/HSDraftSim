//
//  MainDraftViewController.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/6.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class MainDraftViewController: UIViewController,HSCardViewProtocol,UITableViewDelegate,UITableViewDataSource {
    
    var legendaryCards : NSArray = []
    var epicCards : NSArray = []
    var rareCards : NSArray = []
    var commonCards : NSArray = []
    
    ///当前抽到的一包
    var draftedCards : NSArray = []
    
    ///剩余的包数
    var remainCardPackages : Int = 60
    
    ///本次已经打开的包数
    var cardPackagesOpened : Int = 0
    
    ///统计已经抽到的各类张数
    var draftedCommon : Int = 0
    var draftedRare : Int = 0
    var draftedEpic : Int = 0
    var draftedLegendary : Int = 0

    
    var discoveredCardsScroll : UIScrollView = UIScrollView()
    var resultTable : UITableView = UITableView()
    var draftButton : UIButton = UIButton()
    var remainLabel : UILabel = UILabel()
    var openedLabel : UILabel = UILabel()
    
    var isDrafting : Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpNavigationBar()
        self.setUpInitialLooking()
        self.setUpActions()
        self.setUpOnlineData()
        self.loadJSONFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //*********************************************//
    //MARK: - controller一般设置
    //*********************************************//
    
    ///导航栏设置
    func setUpNavigationBar(){
        let rightItem = UIBarButtonItem(title: "再来十包", style: .Plain, target: self, action: #selector(self.test))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    ///初始化视图
    func setUpInitialLooking(){
        view.backgroundColor = DZXColorKit.viewBkg
        automaticallyAdjustsScrollViewInsets = false
        
        discoveredCardsScroll.backgroundColor = UIColor.whiteColor()
//        discoveredCardsScroll.frame = CGRectMake(30, view.frame.height - 360, view.frame.width - 60, 330)
        discoveredCardsScroll.layer.cornerRadius = 10
        discoveredCardsScroll.layer.masksToBounds = true
        discoveredCardsScroll.pagingEnabled = true
        view.addSubview(discoveredCardsScroll)
        
        resultTable.backgroundColor = UIColor.whiteColor()
        resultTable.layer.cornerRadius = 10
        resultTable.layer.masksToBounds = true
        view.addSubview(resultTable)
        
        remainLabel = DZXUIKit.createLabel("还剩\(remainCardPackages)包", textColor: DZXColorKit.black, adjustWidth: nil, adjustHeight: nil, fontSize: 30)
        view.addSubview(remainLabel)
        
        openedLabel = DZXUIKit.createLabel("已开\(cardPackagesOpened)包", textColor: DZXColorKit.black, adjustWidth: nil, adjustHeight: nil, fontSize: 30)
        view.addSubview(openedLabel)
        
        draftButton = DZXUIKit.createButton("开一包", textColor: DZXColorKit.black, fontSize: 30, backgroundColor: DZXColorKit.btnBkg, cornerRadius: 5, borderColor: nil, borderWidth: nil, target: self, action: #selector(self.draftFiveCards))
        view.addSubview(draftButton)
        
        self.initializeConstraints()
    }
    
    ///初始化约束
    func initializeConstraints(){
        discoveredCardsScroll.snp_makeConstraints { (make) in
            make.height.equalTo(view).dividedBy(2)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
        
        draftButton.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(64 + 20)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
            make.width.equalTo(80)
        }
        
        remainLabel.snp_makeConstraints { (make) in
            make.left.equalTo(resultTable)
            make.width.equalTo(draftButton)
            make.height.equalTo(draftButton)
            make.top.equalTo(draftButton)
        }
        
        openedLabel.snp_makeConstraints { (make) in
            make.right.equalTo(resultTable)
            make.width.equalTo(draftButton)
            make.height.equalTo(draftButton)
            make.top.equalTo(draftButton)
            
        }
        
        resultTable.snp_makeConstraints { (make) in
            make.top.equalTo(draftButton.snp_bottom).offset(20)
            make.bottom.equalTo(discoveredCardsScroll.snp_top).offset(-30)
            make.left.equalTo(discoveredCardsScroll)
            make.right.equalTo(discoveredCardsScroll)
        }
        
    }
    
    ///设置委托和捆绑关系
    func setUpActions(){
        resultTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        resultTable.delegate = self
        resultTable.dataSource = self
    }
    
    ///网络数据初始化
    func setUpOnlineData(){
        
    }
    
    ///默认返回方法
    func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func loadJSONFile(){
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
    /*
     {"id":"NEW1_036","type":"SPELL","set":"EXPERT1","dust":[100,800,20,100],"rarity":"RARE","texture":"W2_414_D","flavor":"“大声吼出来！把你的怒气吼出来！”——对训练中的战士的建议","text":"在本回合中，你的随从的生命值无法被降到1点以下。抽一张牌。","name":"命令怒吼","collectible":true,"playerClass":"WARRIOR","cost":2,"artist":"Wayne Reynolds"}
     {"id":"LOE_006","texture":"HS6-010_D","type":"MINION","howToEarn":"加入“探险者协会”冒险模式，在探险者大厅中解锁。","set":"LOE","mechanics":["BATTLECRY"],"rarity":"COMMON","collectible":true,"flavor":"馆长的脾气不太好，这都要归咎于那些攀爬书架的熊孩子和企图复活展品的疯子们。","cost":2,"name":"博物馆馆长","howToEarnGolden":"加入“探险者协会”冒险模式，在探险者大厅中解锁制作。","health":2,"playerClass":"PRIEST","text":"<b>战吼：发现</b>一张<b>亡语</b>牌。","artist":"Steve Prescott","attack":1}
    */
    
    func splitCardsByRarity(allCards:NSArray){
        let commons = NSMutableArray()
        let rares = NSMutableArray()
        let epics = NSMutableArray()
        let legendaries = NSMutableArray()
        
        for item in allCards{
            var card : HSCard = HSCard()
            
//            let mechanics : NSArray?
//            let fMechanics : NSMutableArray
            
            let type : String = (item as! NSDictionary).objectForKey("type")as! String
            if(type == "HERO"){
                continue
            }
            let rarity : String = (item as! NSDictionary).objectForKey("rarity")as! String
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
                continue
            default:
                break
            }
            let name : String = (item as! NSDictionary).objectForKey("name")as! String
            var flavor : String
            if(name != "消失"){
                flavor = (item as! NSDictionary).objectForKey("flavor")as! String
            }else{
                flavor = ""
            }
            let cost : Int = (item as! NSDictionary).objectForKey("cost")as! Int
            let duration : Int? = (item as! NSDictionary).objectForKey("duration")as? Int
            
            var race : String?
            var frace : HSMinionRace? = nil
            var attack : Int?
            var health : Int?
            
            attack = (item as! NSDictionary).objectForKey("attack")as? Int
            health = (item as! NSDictionary).objectForKey("health")as? Int
            race = (item as! NSDictionary).objectForKey("race")as? String
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
                card = HSCard(name: name, flavor: flavor, rarity: frarity, cost: cost, type: ftype, attack: attack, health: health, race: frace, duration: duration)
            }else if(type == "SPELL"){
                ftype = .SPELL
                card = HSCard(name: name, flavor: flavor, rarity: frarity, cost: cost, type: ftype, attack: nil, health: nil, race: nil, duration: nil)
            }else if(type == "WEAPON"){
                ftype = .WEAPON
                card = HSCard(name: name, flavor: flavor, rarity: frarity, cost: cost, type: ftype, attack: nil, health: nil, race: nil, duration: nil)
            }
            
            switch card.rarity {
            case .COMMON:
                commons.addObject(card)
            case .RARE:
                rares.addObject(card)
            case .EPIC:
                epics.addObject(card)
            case .LEGENDARY:
                legendaries.addObject(card)
            case .FREE:
                break
            }
        }
        commonCards = NSArray(array: commons)
        rareCards = NSArray(array: rares)
        epicCards = NSArray(array: epics)
        legendaryCards = NSArray(array: legendaries)
        print(commonCards.count)
        print(rareCards.count)
        print(epicCards.count)
        print(legendaryCards.count)
    }
    
    /*
     1/5 - rare
     1/25 - epic
     1/100 - Legendary
     rest - common
     */
    func draftFiveCards(){
        //        isDrafting = true
        //        self.draftButton.userInteractionEnabled = false
        //        self.draftButton.setTitle("抽取中...", forState: .Normal)
        if(self.remainCardPackages >= 1){
            self.remainCardPackages -= 1
            self.remainLabel.text = "还剩\(self.remainCardPackages)包"
            self.cardPackagesOpened += 1
            self.openedLabel.text = "已开\(self.cardPackagesOpened)包"
            
            let allCardsCount = legendaryCards.count + epicCards.count + rareCards.count + commonCards.count
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
            draftedCards = NSArray(array: drafted)
            self.addDraftedCardsToScroll(discoveredCardsScroll)
        }else{
            Tool.showErrorHUD("请购买更多的包")
        }
    }
    
    func addDraftedCardsToScroll(scroll:UIScrollView){
        for item in scroll.subviews{
            item.removeFromSuperview()
        }
        scroll.layoutIfNeeded()
        for i in 0...(draftedCards.count - 1){
            let card = draftedCards[i] as! HSCard
            let cView = HSCardView(frame: CGRectMake(CGFloat(i) * scroll.frame.width + (scroll.frame.width - 200) / 2, (scroll.frame.height - 300) / 2, 200, 300), card: card)
//            let cView = HSCardView(frame: CGRectMake(CGFloat(i) * 200 + CGFloat(i + 1) * 10, 330 / 2 - 150, 200, 300), card: card)
            cView.delegate = self
            scroll.addSubview(cView)
        }
        scroll.contentSize = CGSizeMake(5 * scroll.frame.width,0)
        scroll.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func test(){
        self.remainCardPackages += 10
        self.remainLabel.text = "还剩\(self.remainCardPackages)包"
    }
    
    func cardIsClicked(discovered: Bool, rarity: HSRarity) {
        
        if(!discovered){
            if(rarity != .COMMON){
                var color = UIColor()
                switch rarity {
                case .LEGENDARY:
                    draftedLegendary += 1
                    color = UIColor(red: 1, green: 0.5, blue: 0, alpha: 0.8)
                case .EPIC:
                    draftedEpic += 1
                    color = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 0.8)
                case .RARE:
                    draftedRare += 1
                    color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
                case .COMMON:
                    draftedCommon += 1
                    color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
                default:
                    break
                }
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                UIView.setAnimationCurve(.EaseIn)
                discoveredCardsScroll.backgroundColor = color
                UIView.commitAnimations()
                discoveredCardsScroll.scrollEnabled = false
                
                let block : dispatch_block_t = {
                    [unowned self] in
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(0.5)
                    UIView.setAnimationCurve(.EaseIn)
                    self.discoveredCardsScroll.backgroundColor = UIColor.whiteColor()
                    UIView.commitAnimations()
                    self.discoveredCardsScroll.scrollEnabled = true
                }
                DZXSystemKit.sleepDoubleTime(0.5, blockToExecute: block)
                self.resultTable.reloadData()
            }else{
                draftedCommon += 1
                self.resultTable.reloadData()
            }
        }
    }
    
    //*********************************************//
    //MARK: - tableView一般设置
    //*********************************************//
    
    ///定制cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "已抽取\(draftedCommon)张普通卡"
        case 1:
            cell.textLabel?.text = "已抽取\(draftedRare)张稀有卡"
        case 2:
            cell.textLabel?.text = "已抽取\(draftedEpic)张史诗卡"
        case 3:
            cell.textLabel?.text = "已抽取\(draftedLegendary)张传说卡"
        default:
            break
        }
        return cell
    }
    
    ///每个section内行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    ///设置行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        tableView.layoutIfNeeded()
        return tableView.frame.height / 4
    }
    
    ///section数目
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    ///尾视图高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    ///首视图高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    ///选中某行的响应
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
