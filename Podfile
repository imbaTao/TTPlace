platform :ios, '10.0'

inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'


##锁定target 为10.0，否则报错
#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      deployment_target = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
#      if deployment_target.to_f < 10.0
#        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
#      end
#    end
#  end
#end


def marcoPods
  # ------ 基础库
  # YY大神的库，很多扩展很有用
  pod 'YYKit'
  
  # 类扩展
  pod 'SwifterSwift', '~> 5.0'  # https://github.com/SwifterSwift/SwifterSwift
  #---------------------------------------------------------------------------------------------------------------------

  # ------ UI 类
  # HUD
  pod 'MBProgressHUD'
  
  # 布局
  pod 'SnapKit'

  # 网络图片加载
  pod 'Kingfisher','~> 5.15.8'
  
  # 空视图展示
  pod 'DZNEmptyDataSet', '~> 1.0'  # https://github.com/dzenbot/DZNEmptyDataSet
  
  # 转场动画库
  pod 'Hero'
  
  #键盘控制库
#  pod 'IQKeyboardManagerSwift', '~> 6.0'  # https://github.com/hackiftekhar/IQKeyboardManager
  
  # 日期库
#  pod 'DateToolsSwift', '~> 5.0'  # https://github.com/MatthewYork/DateTools
#  pod 'SwiftDate', '~> 6.0'  # https://github.com/malcommac/SwiftDate
  
  #Rx相关库
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
#  pod 'RxViewController', '~> 1.0'  # https://github.com/devxoul/RxViewController
  pod 'RxGesture', '~> 3.0'  # https://github.com/RxSwiftCommunity/RxGesture
  pod 'RxOptional', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxOptional
#  pod 'RxTheme', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxTheme

#  pod "UINavigation-SXFixSpace", "~> 1.2.4" #修复导航栏两侧间距

  # 一键电话登录闪验SDK
  #  pod 'CL_ShanYanSDK'

  # 高德定位
  #  pod 'AMapLocation'

  # 配合图片浏览器用
  pod 'SDWebImage'
  
  # 图片浏览库
  pod 'ZLPhotoBrowser'
  
  # pod 'TZImagePickerController'#相册资源框架
  pod 'JXSegmentedView'

  # 下拉刷新库和空数据显示
  # pod 'DZNEmptyDataSet', '~> 1.0'  #https://github.com/dzenbot/DZNEmptyDataSet
  pod 'MJRefresh'#刷新头,必须有的库

  # 谷歌pop动画框架
  pod 'pop', :git => 'https://github.com/facebook/pop.git'
  
  #  pod 'RTRootNavigationController'#全屏pop手势和push
  #---------------------------------------------------------------------------------------------------------------------
  
  
  
  # ------ 网络类
  # 网络请求
  pod 'Alamofire'
  
  # Json转模型
  pod 'HandyJSON'
  pod 'SwiftyJSON'
  #---------------------------------------------------------------------------------------------------------------------
  

  
  # ------ 资源管理类
  # 图片资源管理库，也可以管理bundle等资源,还有UITableViewCell注册Identifer绑定类型,很方便且安全
  pod 'R.swift' #https://github.com/mac-cain13/R.swift/blob/master/Documentation/Examples.md#colors
  #---------------------------------------------------------------------------------------------------------------------
  

  
  
  # ------ 辅助类，埋点，分享等
  pod 'UMCCommon'#友盟统计
  pod 'Bugly' #腾讯BUG崩溃采集库
  #---------------------------------------------------------------------------------------------------------------------

  
  
  
  # ------ 工具类
  # Keychain密码
  # pod 'KeychainAccess', '~> 4.0'  # https://github.com/kishikawakatsumi/KeychainAccess
  
  #DEBUG调试工具
  #pod 'FLEX', '~> 4.0', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX
  #DEBUG模式  mac查看UI部分
  pod 'LookinServer', :configurations => ['Debug']#DEBug调试UI用,得配合Lookin客户端
  #---------------------------------------------------------------------------------------------------------------------

  
  // js通信
  pod 'WebViewJavascriptBridge', '~> 6.0'
end


target 'TTPlace' do
  marcoPods
end


