//
//  TSAdertView.swift
//  TSLaunch
//
//  Created by 任鹏杰 on 2018/6/22.
//  Copyright © 2018年 任鹏杰. All rights reserved.
//

import UIKit
import SnapKit
import TSUtility
import Kingfisher

let TS_showAdvertNotification = "showAdvertNotification"

public class TSAdvertView: UIView {

    private var contentImageView: UIImageView!
    
    public var iconImageView: UIImageView!
    
    private var countDownButton: UIButton!
    
    /**
     广告页显示时间，默认3秒
     */
    var timeCount: Int = 3
    
    //GCD定时器
    var timer: DispatchSourceTimer!
    
    //跳转区域回调
    var jumpBlock: ((Bool)->Void)?
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubViews()
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.countDownButton.layer.masksToBounds = true
        self.countDownButton.layer.cornerRadius = self.countDownButton.frame.size.height / 2
    }
    
    //MARK: --- Set Method ---
    
    /**
     设置广告图片
     */
        func setAdvertImage(imageStr: String?) -> Void {
    

            if let url = imageStr, url.count > 1 {
                
                contentImageView.setImage(url: url, placeHolder: self.contentImageView.image ?? UIImage())
                startGCDTimer()
                
                self.countDownButton.isHidden = false
                self.contentImageView.isUserInteractionEnabled = true
            }
        }
    
    /**
     设置广告显示时间
     */
    func setAdvertDisplayTime(time: Int?) -> Void {
        
        guard countDownButton.isHidden == false else {
            
            return
        }
        
        if let tempTime = time, tempTime >= 2 {
            
            timeCount = tempTime
            countDownButton.setTitle("跳过 "+"\(self.timeCount)s", for: UIControl.State.normal)
            
        }
    }
    
    
    
    func setDefultLaunchImage(image: UIImage) -> Void {
        
        self.contentImageView.image = image
    }
    
    func setDefultIconImage(image: UIImage) -> Void {
        
        self.iconImageView.image = image
    }
    
    //MARK: --- Event Click ---
    @objc func timeCountClick() -> Void {
        
//        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
//
//            self.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
//            self.alpha = 0.0
//
//
//        }) { (result) in
//
//            self.removeFromSuperview()
//        }
        self.jumpBlock?(false)
        
        if self.timer != nil {
            
            self.timer.cancel()
            self.timer = nil
        }
    }
    
    @objc func tapClick(gr: UIGestureRecognizer) -> Void {
        
        self.jumpBlock?(true)
//        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: TS_showAdvertNotification)))
//        removeFromSuperview()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




//MARK: --- 定时器 ---
extension TSAdvertView {
    
    func startGCDTimer() -> Void {

        //全局队列下，创建时间源
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        
        //设置循环时间，开始时间
        timer.schedule(wallDeadline: .now() + 1, repeating: .seconds(1))
        
        //时间源出发事件
        timer.setEventHandler {
            
            self.timeCount = self.timeCount - 1
            
            TSLog("倒计时中：\(self.timeCount)")
            
            if self.timeCount <= 0 {
                
                //取消时间源
                self.timer.cancel()
                
                DispatchQueue.main.async(execute: {
                    
                    TSLog("倒计时结束")
                    self.timeCountClick()
                })
            }else{
                
                DispatchQueue.main.async(execute: {
                    
                    self.countDownButton.setTitle("跳过 "+"\(self.timeCount)s", for: UIControl.State.normal)
                })
            }
        }
        //启动事件源
        timer.resume()
    }
}



extension TSAdvertView {
    
    func addSubViews() -> Void {
    
        contentImageView = UIImageView.init(frame: CGRect())
        contentImageView.contentMode = .scaleToFill
        contentImageView.isUserInteractionEnabled = false
//        contentImageView.image = #imageLiteral(resourceName: "defaultAdvert")
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(gr:)))
        contentImageView.addGestureRecognizer(tap)
        
        addSubview(contentImageView)
        
        iconImageView = UIImageView.init()
        //        iconImageView.image = #imageLiteral(resourceName: "defaultLaunch")
        let placeholderTop = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(gr:)))
        iconImageView.addGestureRecognizer(placeholderTop)
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(UIDevice().ts.isIPhoneX ? -30 : 0)
            make.height.equalTo(90.ts.scale())
        }
        
        contentImageView.snp.makeConstraints({ (make) in
            
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(iconImageView)
        })
        
        countDownButton = UIButton.init(type: UIButton.ButtonType.custom)
        countDownButton.titleLabel?.font = 14.ts.font()
        countDownButton.setTitle("跳转 3s", for: UIControl.State.normal)
        countDownButton.isHidden = true
        //        countDownButton.setBackgroundImage(UIImage.createImage(color: uicolor(rgbValue: 0x000000, alpha: 0.4)), for: UIControlState.normal)
        countDownButton.addTarget(self, action: #selector(timeCountClick), for: UIControl.Event.touchUpInside)
        
        addSubview(countDownButton)
        countDownButton.snp.makeConstraints({ (make) in
            
            make.right.equalToSuperview().offset(-10.ts.scale())
            make.top.equalToSuperview().offset(30.ts.scale())
            make.width.equalTo(70.ts.scale())
            make.height.equalTo(28.ts.scale())
        })
    }

}

extension UIImageView {
    
    
    func setImage(url : String?) {
        
        guard let urlStr = url, urlStr.count > 1 else {
            
            TSLog("图片地址错误")
            return
        }
        
        guard let url = URL(string: urlStr) else {
            
            TSLog("无法生成正确的url")
            return
        }
        
        let res : ImageResource = ImageResource(downloadURL: url)
        
        self.kf.setImage(with: res)
    }
    
    func setImage(url : String?, placeHolder: UIImage) {
        
        guard let urlStr = url, urlStr.count > 1 else {
            self.image = placeHolder
            return
        }
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let res : ImageResource = ImageResource(downloadURL: url)
        
        self.kf.setImage(with: res, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
