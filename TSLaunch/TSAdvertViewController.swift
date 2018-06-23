//
//  TSAdvertViewController.swift
//  启动结构控制器
//
//  Created by 任鹏杰 on 2018/6/22.
//  Copyright © 2018年 任鹏杰. All rights reserved.
//

import UIKit
import SnapKit
import TSUtility

class TSAdvertViewController: UIViewController {

    var advertView = TSAdvertView()
    
    var advertTapClick: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resourc˜es that can be recreated.
    }
    
}

extension TSAdvertViewController {
    
    func addSubViews() -> Void {
        
        self.view.addSubview(advertView)
        advertView.snp.makeConstraints({ (make) in
            
            make.edges.equalToSuperview()
        })
        
        advertView.tapContnetBlock = advertTapClick
        advertView.tapTimeCountBlock = advertTapClick
    }
}



