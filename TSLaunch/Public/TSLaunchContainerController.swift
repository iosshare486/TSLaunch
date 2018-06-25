//
//  TSLaunchContainerController.swift
//  启动结构控制器
//
//  Created by 任鹏杰 on 2018/6/22.
//  Copyright © 2018年 任鹏杰. All rights reserved.
//

import UIKit
import TSUtility

public class TSLaunchContainerController: UIViewController {

    public let config = TSLaunchConfig()
    
    //主控制器
    private var mainController: UIViewController!
    
    //广告页控制器
    private var advertViewController: TSAdvertViewController!
    
    private var enterViewController: UIViewController?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViews()
        
        self.startGCDTimer()
    }
    
    func startGCDTimer() -> Void {
        
        DispatchTimer(timeInterval: 1, repeatCount: 2) { (timer, count) in
            
            TSLog(count)
            
            if count == 0 &&  self.config.isAdvertShowing == false {
                
                self.switchViewController(from: self.advertViewController, to: self.mainController)
            }
        }
    }
    
    //切换控制器
    func switchViewController(from: UIViewController, to: UIViewController) -> Void {
        
        transition(from: from, to: to, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            
            TSLog("动画开始执行")
            
        }) { (result) in
            
            TSLog("动画执行完成")
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension TSLaunchContainerController {
    
    //MARK: ======  控制器添加及设置  ======
    func addChildViews() -> Void {
        
        advertViewController = config.getAdvertViewController()
        
        advertViewController.advertTapClick = {
            
            self.switchViewController(from: self.advertViewController, to: self.mainController)
            
            self.config.tapLaunchBlock?()
        }
        addChildViewController(advertViewController)
        advertViewController.didMove(toParentViewController: self)
        self.view.addSubview(advertViewController.view)
        
        advertViewController.advertView.setDefultIconImage(image: config.getIconImage())
        advertViewController.advertView.setDefultLaunchImage(image: config.getLaunchImage())
        
        mainController = config.getMainViewController()
        
        addChildViewController(mainController)
    }
}


public func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
{
    if repeatCount <= 0 {
        return
    }
    let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var count = repeatCount
    timer.schedule(wallDeadline: .now(), repeating: timeInterval)
    timer.setEventHandler(handler: {
        count -= 1
        DispatchQueue.main.async {
            handler(timer, count)
        }
        if count == 0 {
            timer.cancel()
        }
    })
    timer.resume()
}
