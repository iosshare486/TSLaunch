#
#  Be sure to run `pod spec lint TSLaunch.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "TSLaunch"
s.version      = "1.0.7"
s.summary      = "this is app Launch"
s.description  = <<-DESC
这是启动结构，可以用于广告页和根控制器之间的切换
DESC
s.platform     = :ios, "8.0"
s.homepage     = "https://www.jianshu.com/u/8a7102c0b777"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "yuchenH" => "huangyuchen@caiqr.com" }

s.source       = { :git => "http://gitlab.caiqr.com/ios_module/TSLaunch.git", :tag => s.version }
s.source_files  = "TSLaunch/Public"
s.framework  = "UIKit","Foundation"
s.swift_version = '4.0'
s.requires_arc = true

s.dependency 'TSUtility'
s.dependency 'Kingfisher', '~> 4.8.1'
s.dependency 'SnapKit', '~> 4.0.0'

end
