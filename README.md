#### TSLaunch使用

使用TSLaunchConfig来配置相关信息，相关方法如下

    /**
     设置默认图片
     */
    public func setLaunchImage(image: UIImage) -> Void 
    
    /**
     获取默认图片
     */
    public func getLaunchImage() -> UIImage 
    
    /**
     设置底部默认icon
     */
    public func setIconImage(image: UIImage) -> Void
    
    /**
     获取底部默认icon
     */
    public func getIconImage() -> UIImage 
    
    /**
     设置应用根控制器
     */
    public func setMainViewController(_ vc: UIViewController) -> Void 
    
     /**
     获取应用根控制器
     */
    public func getMainViewController() -> UIViewController {
        
        return self.mainViewController
    }
    
    /**
    设置广告图片
    */
    public func setAdvertUrl(url: String) -> Void 
    
    /**
    设置广告页显示时间
    */
    public func setAdvertTime(time: Int) -> Void

###举例

      func application(_ application: UIApplication,    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        
        let launch = TSLaunchContainerController()
        launch.config.setMainViewController(ViewController())
        launch.config.setLaunchImage(image: #imageLiteral(resourceName: "defaultAdvert"))
        launch.config.setIconImage(image: #imageLiteral(resourceName: "defaultLaunch"))
        launch.config.tapLaunchBlock = {
            
            let view = UIView.init()
            view.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
            view.backgroundColor = UIColor.green
            self.window?.addSubview(view)
        }
        
        self.window?.rootViewController = launch
        
        launch.config.setAdvertUrl(url: "https://ojhwnbiut.qnssl.com/Fupd28FbVoiYvEVZwwlfW5PWahX4")
        launch.config.setAdvertTime(time: 4)
        
        return true
    }