//
//  TSLaunchConfig.swift
//  TSLaunch
//
//  Created by 任鹏杰 on 2018/6/23.
//  Copyright © 2018年 任鹏杰. All rights reserved.
//

import UIKit

public class TSLaunchConfig {
    
    private var defaultLaunchImage = UIImage()
    private var defaultIconImage = UIImage()
    
    public var tapLaunchBlock: (() -> Void)?
    
    private var mainViewController = UIViewController()
    
    private var advertViewController = TSAdvertViewController()
    
    private var enterViewController: UIViewController?

    public var isAdvertShowing = false
    
    /**
     设置默认图片
     */
    public func setLaunchImage(image: UIImage) -> Void {
        
        self.defaultLaunchImage = image
    }
    
    /**
     获取默认图片
     */
    public func getLaunchImage() -> UIImage {
        
        return self.defaultLaunchImage
    }
    
    /**
     设置底部默认icon
     */
    public func setIconImage(image: UIImage) -> Void {
        
        self.defaultIconImage = image
    }
    
    /**
     获取底部默认icon
     */
    public func getIconImage() -> UIImage {
        
        return self.defaultIconImage
    }
    
    /**
     设置应用根控制器
     */
    public func setMainViewController(_ vc: UIViewController) -> Void {
        
        self.mainViewController = vc
    }
    
    /**
     获取应用根控制器
     */
    public func getMainViewController() -> UIViewController {
        
        return self.mainViewController
    }
    
    /**
     获取广告控制器
     */
    func getAdvertViewController() -> TSAdvertViewController {
        
        return self.advertViewController
    }
    
    //设置广告图片
    public func setAdvertUrl(url: String) -> Void {
        
        self.isAdvertShowing = true
        
        self.advertViewController.advertView.setAdvertImage(imageStr: url)
    }
    
    /**
     设置广告页显示时间
     */
    public func setAdvertTime(time: Int) -> Void {
        
        guard time > 3 else {
            
            return
        }
        
        self.advertViewController.advertView.setAdvertDisplayTime(time: time)
    }
    
    /**
     设置进入控制器
     */
    public func setEnterViewController(vc: UIViewController?) -> Void {
        
        self.enterViewController = vc
    }
    
    /**
     获取进入控制器
     */
    public func getEnterViewController() -> UIViewController? {
        
        return self.enterViewController
    }
}
