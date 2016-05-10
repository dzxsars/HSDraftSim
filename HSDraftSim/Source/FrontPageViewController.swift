//
//  FrontPageViewController.swift
//  HSDraftSim
//
//  Created by DuZhiXia on 16/5/8.
//  Copyright © 2016年 geralt. All rights reserved.
//

import UIKit

class FrontPageViewController: UIViewController {
    
    var toDraftButton : UIButton = UIButton()
    var toCollectionButton : UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpNavigationBar()
        self.setUpInitialLooking()
        self.setUpActions()
        self.setUpOnlineData()

        HSDraftUtils.sharedInstance().initialDataFromJSONFile()

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
        
        toDraftButton = DZXUIKit.createButton("牌店", textColor: DZXColorKit.black, fontSize: 20, backgroundColor: nil, cornerRadius: 5, borderColor: DZXColorKit.border, borderWidth: 1, target: self, action: #selector(self.toDraft))
        view.addSubview(toDraftButton)
        
        toCollectionButton = DZXUIKit.createButton("我的收藏", textColor: DZXColorKit.black, fontSize: 20, backgroundColor: nil, cornerRadius: 5, borderColor: DZXColorKit.border, borderWidth: 1, target: self, action: #selector(self.toCollection))
        view.addSubview(toCollectionButton)
        
        self.initializeConstraints()
    }
    
    ///初始化约束
    func initializeConstraints(){
        toDraftButton.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(32 + 20)
            make.height.equalTo(30)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.width / 6)
        }
        
        toCollectionButton.snp_makeConstraints { (make) in
            make.top.equalTo(toDraftButton.snp_bottom).offset(10)
            make.height.equalTo(30)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.width / 6)
        }
    }
    
    ///设置委托和捆绑关系
    func setUpActions(){
        
    }
    
    ///网络数据初始化
    func setUpOnlineData(){
        
    }
    
    ///默认返回方法
    func goBack(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //*********************************************//
    // MARK: - 按钮响应
    //*********************************************//
    func toDraft(){
        let destVC = MainDraftViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func toCollection(){
        let destVC = MyCollectionViewController()
        self.navigationController?.pushViewController(destVC, animated: true)
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
