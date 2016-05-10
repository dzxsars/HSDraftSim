//
//  MyCollectionViewController.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/8.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var druidCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var hunterCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var mageCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var paladinCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var priestCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var rogueCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var shamanCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var warlockCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var warriorCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    var publicCollection : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var segmentControl : UISegmentedControl = UISegmentedControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpNavigationBar()
        self.setUpActions()
        self.setUpInitialLooking()
        self.setUpOnlineData()

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
        
    }
    
    ///初始化视图
    func setUpInitialLooking(){
        view.backgroundColor = DZXColorKit.viewBkg
        automaticallyAdjustsScrollViewInsets = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        layout.headerReferenceSize=CGSizeZero
        layout.footerReferenceSize=CGSizeZero
        druidCollection.setCollectionViewLayout(layout, animated: false)
        druidCollection.backgroundColor = DZXColorKit.viewBkg
        druidCollection.pagingEnabled = true
        view.addSubview(druidCollection)
        
        let hunterLayout = UICollectionViewFlowLayout()
        hunterLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        hunterLayout.headerReferenceSize=CGSizeZero
        hunterLayout.footerReferenceSize=CGSizeZero
        hunterCollection.setCollectionViewLayout(hunterLayout, animated: false)
        hunterCollection.backgroundColor = DZXColorKit.viewBkg
        hunterCollection.pagingEnabled = true
        view.addSubview(hunterCollection)
        
        let mageLayout = UICollectionViewFlowLayout()
        mageLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        mageLayout.headerReferenceSize=CGSizeZero
        mageLayout.footerReferenceSize=CGSizeZero
        mageCollection.setCollectionViewLayout(mageLayout, animated: false)
        mageCollection.backgroundColor = DZXColorKit.viewBkg
        mageCollection.pagingEnabled = true
        view.addSubview(mageCollection)
        
        let paladinLayout = UICollectionViewFlowLayout()
        paladinLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        paladinLayout.headerReferenceSize=CGSizeZero
        paladinLayout.footerReferenceSize=CGSizeZero
        paladinCollection.setCollectionViewLayout(paladinLayout, animated: false)
        paladinCollection.backgroundColor = DZXColorKit.viewBkg
        paladinCollection.pagingEnabled = true
        view.addSubview(paladinCollection)
        
        let priestLayout = UICollectionViewFlowLayout()
        priestLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        priestLayout.headerReferenceSize=CGSizeZero
        priestLayout.footerReferenceSize=CGSizeZero
        priestCollection.setCollectionViewLayout(priestLayout, animated: false)
        priestCollection.backgroundColor = DZXColorKit.viewBkg
        priestCollection.pagingEnabled = true
        view.addSubview(priestCollection)
        
        let rogueLayout = UICollectionViewFlowLayout()
        rogueLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        rogueLayout.headerReferenceSize=CGSizeZero
        rogueLayout.footerReferenceSize=CGSizeZero
        rogueCollection.setCollectionViewLayout(rogueLayout, animated: false)
        rogueCollection.backgroundColor = DZXColorKit.viewBkg
        rogueCollection.pagingEnabled = true
        view.addSubview(rogueCollection)
        
        let shamanLayout = UICollectionViewFlowLayout()
        shamanLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        shamanLayout.headerReferenceSize=CGSizeZero
        shamanLayout.footerReferenceSize=CGSizeZero
        shamanCollection.setCollectionViewLayout(shamanLayout, animated: false)
        shamanCollection.backgroundColor = DZXColorKit.viewBkg
        shamanCollection.pagingEnabled = true
        view.addSubview(shamanCollection)
        
        let warlockLayout = UICollectionViewFlowLayout()
        warlockLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        warlockLayout.headerReferenceSize=CGSizeZero
        warlockLayout.footerReferenceSize=CGSizeZero
        warlockCollection.setCollectionViewLayout(warlockLayout, animated: false)
        warlockCollection.backgroundColor = DZXColorKit.viewBkg
        warlockCollection.pagingEnabled = true
        view.addSubview(warlockCollection)
        
        let warriorLayout = UICollectionViewFlowLayout()
        warriorLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        warriorLayout.headerReferenceSize=CGSizeZero
        warriorLayout.footerReferenceSize=CGSizeZero
        warriorCollection.setCollectionViewLayout(warriorLayout, animated: false)
        warriorCollection.backgroundColor = DZXColorKit.viewBkg
        warriorCollection.pagingEnabled = true
        view.addSubview(warriorCollection)
        
        let publicLayout = UICollectionViewFlowLayout()
        publicLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        publicLayout.headerReferenceSize=CGSizeZero
        publicLayout.footerReferenceSize=CGSizeZero
        publicCollection.setCollectionViewLayout(publicLayout, animated: false)
        publicCollection.backgroundColor = DZXColorKit.viewBkg
        publicCollection.pagingEnabled = true
        view.addSubview(publicCollection)
        
        hunterCollection.hidden = true
        mageCollection.hidden = true
        paladinCollection.hidden = true
        priestCollection.hidden = true
        rogueCollection.hidden = true
        shamanCollection.hidden = true
        warlockCollection.hidden = true
        warriorCollection.hidden = true
        publicCollection.hidden = true
        
        segmentControl = UISegmentedControl(items: ["德鲁伊","猎人","法师","圣骑士","牧师","盗贼","萨满","术士","战士","公共"])
        segmentControl.tintColor = DZXColorKit.purple
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(self.segmentControlClicked), forControlEvents: .ValueChanged)
        view.addSubview(segmentControl)
        
        self.initializeConstraints()
    }
    
    ///初始化约束
    func initializeConstraints(){
        segmentControl.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(32 + 10)
            make.height.equalTo(25)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        druidCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        hunterCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        mageCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        paladinCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        priestCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        rogueCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        shamanCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        warlockCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        warriorCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        publicCollection.snp_makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp_bottom).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
    }
    
    ///设置委托和捆绑关系
    func setUpActions(){
        
        druidCollection.delegate = self
        hunterCollection.delegate = self
        mageCollection.delegate = self
        paladinCollection.delegate = self
        priestCollection.delegate = self
        rogueCollection.delegate = self
        shamanCollection.delegate = self
        warlockCollection.delegate = self
        warriorCollection.delegate = self
        publicCollection.delegate = self
        
        druidCollection.dataSource = self
        hunterCollection.dataSource = self
        mageCollection.dataSource = self
        paladinCollection.dataSource = self
        priestCollection.dataSource = self
        rogueCollection.dataSource = self
        shamanCollection.dataSource = self
        warlockCollection.dataSource = self
        warriorCollection.dataSource = self
        publicCollection.dataSource = self
        
        druidCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        hunterCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        mageCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        paladinCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        priestCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        rogueCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        shamanCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        warlockCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        warriorCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        publicCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
   }
    
    ///网络数据初始化
    func setUpOnlineData(){
        self.druidCollection.reloadData()
    }
    
    ///默认返回方法
    func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func segmentControlClicked(){
        druidCollection.hidden = true
        hunterCollection.hidden = true
        mageCollection.hidden = true
        paladinCollection.hidden = true
        priestCollection.hidden = true
        rogueCollection.hidden = true
        shamanCollection.hidden = true
        warlockCollection.hidden = true
        warriorCollection.hidden = true
        publicCollection.hidden = true
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            druidCollection.hidden = false
        case 1:
            hunterCollection.hidden = false
        case 2:
            mageCollection.hidden = false
        case 3:
            paladinCollection.hidden = false
        case 4:
            priestCollection.hidden = false
        case 5:
            rogueCollection.hidden = false
        case 6:
            shamanCollection.hidden = false
        case 7:
            warlockCollection.hidden = false
        case 8:
            warriorCollection.hidden = false
        case 9:
            publicCollection.hidden = false

        default:
            break
        }
    }
    
    //*********************************************//
    // MARK: - Collection Delegate and Datasource
    //*********************************************//
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == druidCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.DRUID).count
        }else if(collectionView == hunterCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.HUNTER).count
        }else if(collectionView == mageCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.MAGE).count
        }else if(collectionView == paladinCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.PALADIN).count
        }else if(collectionView == priestCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.PRIEST).count
        }else if(collectionView == rogueCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.ROGUE).count
        }else if(collectionView == shamanCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.SHAMAN).count
        }else if(collectionView == warlockCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.WARLOCK).count
        }else if(collectionView == warriorCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.WARRIOR).count
        }else if(collectionView == publicCollection){
            return HSDraftUtils.sharedInstance().readByPlayerClass(.ALL).count
        }
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = DZXColorKit.btnBkg
        if(collectionView == druidCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.DRUID)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == hunterCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.HUNTER)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == mageCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.MAGE)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == paladinCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.PALADIN)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == priestCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.PRIEST)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == rogueCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.ROGUE)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == shamanCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.SHAMAN)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == warlockCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.WARLOCK)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == warriorCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.WARRIOR)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }else if(collectionView == publicCollection){
            for v in cell.contentView.subviews{
                v.removeFromSuperview()
            }
            let item = HSDraftUtils.sharedInstance().readByPlayerClass(.ALL)[indexPath.row] as! HSCard
            let cView = HSCardView(frame: CGRectZero, card: item)
            cView.cardBack.hidden = true
            cell.contentView.addSubview(cView)
            cell.layer.cornerRadius = cView.layer.cornerRadius
            cView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(cell.contentView)
            })
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        collectionView.layoutIfNeeded()
        return (CGSize(width: (collectionView.frame.width - 40) / 4, height: (collectionView.frame.width - 50) / 3))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        collectionView.layoutIfNeeded()
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
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
