platform :ios, '10.0'

inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def marcoPods
  #OC部分
#  pod 'Masonry' #布局
  pod 'MBProgressHUD'#HUD
  pod 'MJRefresh'#刷新头
#  pod 'AFNetworking', '~> 4.0'#网络请求
#  pod 'MJExtension'#字典转模型
#  pod 'ReactiveObjC' #响应式
#  pod 'SDWebImage'
#  pod 'BRPickerView' #日期类
  #  pod 'RTRootNavigationController'#全屏pop手势和push
  
  
  
  
  

  #swift部分 --------------
  # 布局
  pod 'SnapKit'
  pod 'SnapKitExtend', '~> 1.0.7'
  pod 'Kingfisher'
  
  
  #Rx相关库
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
  
  #公共部分，有OC库
  pod 'UMCCommon'#友盟统计
  pod 'IQKeyboardManager' #键盘控制库
  pod 'Bugly' #腾讯BUG崩溃采集库
  pod 'YYKit' #大佬的库
  pod "UINavigation-SXFixSpace", "~> 1.2.4" #修复导航栏两侧间距
#  pod 'QMUIKit'#腾讯UI库，不想过度依赖，里面有很多hook，有时自己代码不规范或者特殊原因出现崩溃情况
  
  
  #网络
  pod 'Alamofire', '~> 5.0'
  pod 'SwiftyJSON'
  
  
  #UI查看部分
  pod 'LookinServer', :configurations => ['Debug']#DEBug调试UI用,得配合Lookin客户端
end




target 'TTPlace' do
  marcoPods
end


