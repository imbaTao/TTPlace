//
//  TTTabbarViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/10.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

// tabbar 的全局设置
var tabbarConfiguration = TTTabbarConfiguration()

class TTTabbarViewControllerItemModel: NSObject {
    // 未选中图片名字
    var normalImageName = ""
    
    // 选中item时的图片的名字
    var selectedImageName = ""
    
    // 内容
    var itemContent = ""
     
    // 选中状态
    var selected = false
    
    // 是否突起
    var isTuber = false
    
    // 下标
     var index = 0
    
    // 初始化方法
     init(normalImageName: String, selectedImageName: String, itemContent: String, selected: Bool =  false,isTuber: Bool = false) {
        super.init()
        self.normalImageName = normalImageName
        self.selectedImageName = selectedImageName
        self.itemContent = itemContent
        self.selected = selected
        self.isTuber = isTuber
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    static func == (lhs: TTTabbarViewControllerItemModel, rhs: TTTabbarViewControllerItemModel) -> Bool {
           return lhs.itemContent == rhs.itemContent
    }
}

// viewModel,准备数据源，和相关网络请求等
//class TTTabbarViewControllerViewModel {
//    var sourceData = [TTTabbarViewControllerItemModel]()
//    var items = Observable.just([
//        TTTabbarViewControllerItemModel()
//    ])
//}


// 自定义tabbar导航栏高度, 49感觉有点矮
let TTDefalutBarHeight: CGFloat = 53

// tabbar的总高度
let TTTabbarHeight = HaveSafeArea ? TTDefalutBarHeight + 34 : TTDefalutBarHeight


// 点击代理
protocol  TTTabbarViewControllerDelegate{
    func itemDidSelected(index: Int)
    func canChangePage(index: Int) -> Bool
}

extension TTTabbarViewControllerDelegate{

}

// tabbar的配置
struct TTTabbarConfiguration {
    // 原数据
    var sourceData = [TTTabbarViewControllerItemModel]()
 
    // rx相关包装过后的数据
      var items = Observable.just([
          TTTabbarViewControllerItemModel
      ]())
     
    // 默认选中下标
    var defaultSelectedIndex = 2
    
    // 全局未选中颜色
    var normalClor: UIColor = .gray
    
    // 全局未选中字体,默认10
    var normalFont: UIFont  = UIFont.regular(10)

    // 全局选中颜色
    var selectedColor: UIColor = .black
    
    // 全局选中字体,默认10
    var selectedFont: UIFont  = UIFont.regular(10)
    
     // 图标距离顶部的距离
    var iconTopInteval: CGFloat = HaveSafeArea ? ver(8) : ver(4)
    
    // 文字之间的间距
    var spacingBetweenImageAndTitle = ver(3)
    
    // 是否显示tabbar横线
    var showTabbarLine: Bool = false
    
    // tabbar分割线颜色
//    var segementLineColor: UIColor = rgba(151, 151, 151, 0.4)
    var segementLineColor: UIColor = .clear
    
    // tabbar分割线高度，默认0.05
    var segementLineHeight: CGFloat = 0
}



// tabbar.显示和隐藏信号,true是显示,false是隐藏
var tabbarShowOrHiddenSignal = PublishSubject<Bool>()

// 直接拿到底部
func baseTabbar() -> TTTabbar? {
    if let tabbarViewController = topTabbarVC() {
        return tabbarViewController.htTabbar
    }
    return nil
}

//classNames:[String]
class TTTabbarViewController: UITabBarController,TTTabbarViewControllerDelegate {
    
    // 自定义导航栏
    var htTabbar = TTTabbar()
    
    // vm数据源
//    let vm = TTTabbarViewControllerViewModel()
        
    // 模型数据
    init(itemModels:[TTTabbarViewControllerItemModel]) {
        
        
        // 给模型下标编号
        for index in 0..<itemModels.count {
            let model = itemModels[index]
            model.index = index
        }
        
        //        tabbarConfiguration.items = itemModels
        tabbarConfiguration.sourceData = itemModels
        tabbarConfiguration.items = Observable.just(tabbarConfiguration.sourceData)
        
        
        
        super.init(nibName: nil, bundle: nil)
        
        
        // 显示或隐藏tabbar
        tabbarShowOrHiddenSignal.subscribe(onNext: { [weak self] (value) in
//            self?.htTabbar.isHidden = !value
        }).disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

 
        
        setupTabbar()

    }
    
    // 上次点击的按钮模型
    var lastClickItemModel: TTTabbarViewControllerItemModel?
    
    // 上次点击的时间
    var lastClickTime: UInt64 = 0
    

    
    class MyTabbarContainer: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            
            
            return .init(width: SCREEN_W, height: 200)
        }
    }
    
 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.height = TTTabbarHeight
        tabBar.y = SCREEN_H - TTTabbarHeight
        
        // 把图层移到最上层
        tabBar.bringSubviewToFront(htTabbar)
        htTabbar.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    // 设置tabbar
    func setupTabbar() {
        
        
//         设置默认导航栏两侧的宽度
//        UINavigationConfig.shared()?.sx_defaultFixSpace = 0
        
        
        // 移除之前导航栏上所有子视图
        self.tabBar.removeAllSubviews()
        self.tabBar.addSubview(htTabbar)
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
        }
        
//        lf.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];

        // rx绑定数据源,直接显示
        tabbarConfiguration.items.bind(to: htTabbar.bar.rx.items(cellIdentifier: "TTTabbarItem", cellType: TTTabbarItem.self)) { [weak self] (collectionView, itemModel, cell) in
            cell.rendModel(itemModel)
            if itemModel.selected {
                self!.lastClickItemModel = itemModel
  
            }
        }
        .disposed(by: rx.disposeBag)
  
      
        
        
        //  获取点击行
        htTabbar.bar.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            
            // 如果可以选中，那么选中
            if self?.canChangePage(index: indexPath.row) == true {
              
                
                // 点击的是同一个，就返回,检测是否双击
              var itemModel = tabbarConfiguration.sourceData[indexPath.row]
                if itemModel == self?.lastClickItemModel {
                  
                    // 当前时间
                    let currentTime: UInt64 = mach_absolute_time()
                    
                    // 如果时间小于0.5秒，0.5秒是最早windows双击的缺省值参考，可以调整
                    
                    // UInt64 转秒数
                    func MachTimeToSecs(time: UInt64) -> Double {
                        var  timebase = mach_timebase_info_data_t()
                        mach_timebase_info(&timebase)
                        
                        return Double(time) * Double(timebase.numer) / Double(timebase.denom) / 1e9;
                    }
                    
                    
                    if MachTimeToSecs(time: currentTime - self!.lastClickTime) < 0.5 {
                        // 触发双击事件
                        self?.doubleClickAction(index: indexPath.row)
                    }
                    
                    // 记录上次的点击时间
                    self!.lastClickTime = currentTime
                    return
                }
                
                
                // 有上一个模型
                if (self?.lastClickItemModel != nil) {
                        // 取消上一个选中
                      self?.lastClickItemModel?.selected = false
                      
                    if let lastIndex = tabbarConfiguration.sourceData.firstIndex(where: { item -> Bool in
                               return item == self!.lastClickItemModel
                       }){
                        
                        
                           let lastCell = self!.htTabbar.bar.cellForItem(at: IndexPath(row: lastIndex, section: 0)) as! TTTabbarItem
                            lastCell.rendModel(self!.lastClickItemModel!)
                       }
                }
                
                
                let cell = self!.htTabbar.bar.cellForItem(at: indexPath) as! TTTabbarItem
            
                itemModel.selected = true
                
                cell.rendModel(itemModel)
                
                self?.lastClickItemModel = itemModel
                
                self?.selectedIndex = indexPath.row
                
                self?.itemDidSelected(index: indexPath.row)
                
                
                // 播放动画
                cell.playAnimationIcon([""])
            }
       
            
        }).disposed(by: rx.disposeBag)
        
        
        // 没有选中
//        htTabbar.bar.rx.itemDeselected.subscribe(onNext: { [weak self] (indexPath) in
//        }).disposed(by: self.rx.disposeBag)
        
        // 立即布局刷新bar
        self.view.layoutIfNeeded()
        


    }
    
    
    // 设置默认选中下标
    override func addChild(_ childController: UIViewController) {
        super.addChild(childController)
        
        // 如果有选中的，选中控制器
        for model in tabbarConfiguration.sourceData {
            if model.selected {
                self.selectedIndex = model.index
                break
            }
        }
    }
    
    
    // 动画类型
    struct Constants {
          struct AnimationKeys {
              static let scale = "transform.scale"
              static let rotation = "transform.rotation"
              static let keyFrame = "contents"
              static let positionY = "position.y"
              static let opacity = "opacity"
          }
      }
    
    // item 点击动画
    func getCustomAnimation() -> CAAnimation {
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        //速度控制函数，控制动画运行的节奏
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        animation.duration = 0.2
//        animation.repeatCount = 1
//        animation.autoreverses = true
//        animation.fromValue = NSNumber(value: 0.7)
//        animation.toValue = NSNumber(value: 1.2)
        
        
        
        let animation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.scale)
          animation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
          animation.duration = TimeInterval(0.5)
          animation.calculationMode = CAAnimationCalculationMode.cubic
        return animation
    }
    
    
    
    
    // 选择某个下标
    func itemDidSelected(index: Int) {
       
    }
    
    func clickAnimation(index: Int) {
        let animationKey = "tabBarItemAnimationKey"
        let cell = self.htTabbar.fetchItemWithIndex(index: index)
        cell.itemIcon.layer.removeAnimation(forKey: animationKey)
        cell.itemIcon.layer.add(getCustomAnimation(),forKey: animationKey)
    }
    
    
    // 双击事件
    func doubleClickAction(index: Int) {
        
    }
    
    // 是否可以点击
    func canChangePage(index: Int) -> Bool {
        return true
    }
    
    //显示消息提示框
    func showAlert(title: String,message: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
