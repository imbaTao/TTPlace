platform :ios, '9.0'

inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def marcoPods
  #OC部分
  pod 'Masonry' #布局
  pod 'MBProgressHUD'#HUD
  pod 'ReactiveObjC'#rac响应式编程
  pod 'MJRefresh'#刷新头
  pod 'AFNetworking', '~> 4.0'#网络请求
  pod 'RTRootNavigationController'#全屏pop手势和push
  pod 'MJExtension'#字典转模型
  pod 'TZImagePickerController'#相册资源框架
  pod 'SDWebImage'
  
  
  
  
  
  

  #swift部分 --------------
  # 布局
  pod 'SnapKit'
  pod 'SnapKitExtend', '~> 1.0.7'
  pod 'QMUIKit'
  
  
  #Rx相关库
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'NSObject+Rx'
  
  #公共部分
  pod 'UMCCommon'#友盟统计
  pod 'IQKeyboardManager' #键盘控制库
  pod 'Bugly' #腾讯BUG崩溃采集库
#  pod 'QMUIKit'#腾讯UI库，不想过度依赖，里面有很多hook，有时出现崩溃情况
  
  
  #UI查看部分
  pod 'LookinServer', :configurations => ['Debug']#DEBug调试UI用,得配合Lookin客户端

  
end




target 'HTPlace' do
  marcoPods
end


