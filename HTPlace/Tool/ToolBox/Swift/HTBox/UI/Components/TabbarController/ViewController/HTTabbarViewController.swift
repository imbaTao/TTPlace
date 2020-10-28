//
//  HTTabbarViewController.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/10.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
import RxSwift
import SnapKitExtend
import Kingfisher


//import QMUIKit

// 根据字符串获取类名
func HTClassFromString(classNames: String) -> AnyClass {
    // 工程名
    let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
    return NSClassFromString("\(workName).\(classNames)")!
}


class HTCollectionView: UICollectionView {
    // 代理必须牵到控制器上去,由控制器vm管理数据源
    var flowLayout: UICollectionViewFlowLayout!
    
    
    // 传类名，和layout
    init(classNames:[String],flowLayout: UICollectionViewFlowLayout) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = .white
        _registCell(classNames: classNames)
    }
    
    
    init(lineSpacing: CGFloat,interitemSpacing: CGFloat,classNames:[String])  {
        flowLayout = UICollectionViewFlowLayout.init()
        // 滚动方向相同的间距为minimumLineSpacing  垂直的minimumInteritemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.minimumInteritemSpacing = interitemSpacing
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        
        _registCell(classNames: classNames)
    }
    
    // 注册所需的cell
    func _registCell(classNames: [String]) {
        let _ = classNames.map {
            let cellClass = HTClassFromString(classNames: $0) as! UICollectionViewCell.Type
            self.register(cellClass, forCellWithReuseIdentifier: $0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//class HTTabbar: HTCollectionView {
//
//
//
//
//
//    // tabbar的创建由CollectionView控制,动态平分宽度
//    func itemSelcetd() {
//
//    }
//
//}



extension UICollectionViewCell {
    //    // 渲染方法
    //    func rendModel(model: AnyClass) {
    //
    //    }
}

// 底层通用Cell类
class HTCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
}

// tabbar 的全局设置
var tabbarConfiguration = HTTabbarConfiguration()



// 通用红点标记
class HTBadge: UIView {
    
    // 背景框，随lable的内容而扩大
    var backGroundCircle = UIView()
    
    // 内容文字提示
    var contentLable = UILabel.regular(size: 10, textColor: .white);
    
    // 之前的edge
    var sourceEdge = UIEdgeInsets.zero
    init(edge: UIEdgeInsets) {
        super.init(frame: .zero)
        
        sourceEdge = edge
        
        backGroundCircle.backgroundColor = rgba(222, 10, 24, 1)
        addSubview(backGroundCircle)
        
        
        contentLable.textAlignment = .center
        addSubview(contentLable)
        
        // layout
        contentLable.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.greaterThanOrEqualTo(12)
        }
        
        backGroundCircle.snp.makeConstraints { (make) in
            make.top.equalTo(contentLable.snp.top).offset(-edge.top)
            make.left.equalTo(contentLable.snp.left).offset(-edge.left)
            make.bottom.equalTo(contentLable.snp.bottom).offset(edge.bottom)
            make.right.equalTo(contentLable.snp.right).offset(edge.right)
        }
    }
    
    // 仅显示红点
    func justRedPoint(size: CGSize) {
        self.isHidden = false
        contentLable.text = ""
    
        // 重新约束
        backGroundCircle.snp.remakeConstraints { (make) in
            make.size.equalTo(size)
            make.center.equalTo(self)
        }
        
        // 倒圆角
        backGroundCircle.settingCornerRadius(size.height / 2)
    }

    // 变更bandage数量
    func changeBadgeNumb(numb: Int) {
        if numb == 0 {
            self.isHidden = true
        }else {
            self.isHidden = false
        }
        
        // 重新约束约束
        backGroundCircle.snp.remakeConstraints { (make) in
           make.top.equalTo(contentLable.snp.top).offset(-sourceEdge.top)
           make.left.equalTo(contentLable.snp.left).offset(-sourceEdge.left)
           make.bottom.equalTo(contentLable.snp.bottom).offset(sourceEdge.bottom)
           make.right.equalTo(contentLable.snp.right).offset(sourceEdge.right)
        }
        

        if numb < 100 {
            contentLable.text = "\(numb)"
        }else {
            // 大于100 显示99+
            contentLable.text = "99+"
        }
        
        self.layoutIfNeeded()
        print("\(contentLable.height)")
        
        
        // 导个圆角
        backGroundCircle.settingCornerRadius((contentLable.height + sourceEdge.top + sourceEdge.bottom) / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 设置突起部分视图
class HTTbbarItemTuberView: UIView {
    
    // 绘制的尺寸
    var drawSourceRect = CGRect.zero
    
    // 绘制的突起高度
//    var tuberHeight: CGFloat = 10
    
    // 绘制的填充颜色
    var drawFillColor = UIColor.white
    
    // 绘制的border粗细
    var drawBorderWidth: CGFloat = 1
    
    // 绘制border的颜色
    var drawBorderColor: UIColor = tabbarConfiguration.segementLineColor
    

    
    
    init(drawSourceRect: CGRect,drawFillColor: UIColor,drawBorderWidth: CGFloat) {
        super.init(frame: drawSourceRect)
        
        print(frame)
        self.drawSourceRect = frame
//        self.tuberHeight = tuberHeight
        self.drawFillColor = drawFillColor
        self.drawBorderWidth = drawBorderWidth
        
        
        self.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override func draw(_ rect: CGRect) {
                super.draw(rect)
            print(rect)
//                self.backgroundColor = .white
//                self.layer.backgroundColor = UIColor.clear.cgColor
                self.drawSmoothPath()
            }
  
            func drawSmoothPath() {
                // 高度
                let offset: CGFloat = drawSourceRect.height
                
                let pointCount: Int = 2
                let pointArr:NSMutableArray = NSMutableArray.init()
                
                for i in 0...pointCount {
                    let px: CGFloat =  CGFloat(i) * CGFloat(self.bounds.width / 2)
                    var py: CGFloat = 0
                    switch i {
                    case 0:
                        py = drawSourceRect.size.height
                    case 1:
                        py = 0
                    case 2:
                        py = drawSourceRect.size.height
                    case 3:
                        py = offset + 10
                    default: py = offset
                        
                    }
                    
                    let point: CGPoint = CGPoint.init(x: px, y: py)
                    pointArr.add(point)
                }
                
                let bezierPath = UIBezierPath()
                bezierPath.lineWidth = 1
            
                
                var prevPoint: CGPoint!
                for i in 0 ..< pointArr.count {
                    let currPoint:CGPoint = pointArr.object(at: i) as! CGPoint
                    
                    // 绘制绿色圆圈
        //            let arcPath = UIBezierPath()
        //            arcPath.addArc(withCenter: currPoint, radius: 3, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        //            UIColor.green.setStroke()
        //            arcPath.stroke()
                    
                    // 绘制平滑曲线
                    if i==0 {
                        bezierPath.move(to: currPoint)
                    }
                    else {
                        let conPoint1: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: prevPoint.y)
                        let conPoint2: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: currPoint.y)
                        bezierPath.addCurve(to: currPoint, controlPoint1: conPoint1, controlPoint2: conPoint2)
                    }
                    prevPoint = currPoint
                }
                
                  self.drawBorderColor.setStroke()
                   bezierPath.stroke()
                

                    
                     // 绘制直线
                   let linepath = UIBezierPath()
                   linepath.move(to: pointArr.lastObject as! CGPoint)
                   linepath.addLine(to: pointArr.firstObject as! CGPoint)
                   linepath.lineWidth = 1
                    self.drawBorderColor.setStroke()
                   linepath.stroke()
                
                    UIColor.white.setFill()
                      bezierPath.fill()
            }
}

// itemCell
class HTTabbarItem: HTCollectionViewCell {
    // 图标
    let itemIcon = UIImageView.empty()
    
    // 内容
    let itemContent = UILabel()
    
    // 渲染模型
    var model: HTTabbarViewControllerItemModel?
    
    // badage
    lazy var badge: HTBadge = {
        var badge = HTBadge.init(edge: UIEdgeInsets.init(sameValue: 3))
        addSubview(badge)
        badge.snp.makeConstraints { (make) in
            make.right.equalTo(self.itemIcon.snp.right)
            make.top.equalTo(self.itemIcon.snp.top)
        }
        return badge
    }()
    
    // 突起视图
    lazy var tuberView: HTTbbarItemTuberView = {
        
        var tuberView = HTTbbarItemTuberView.init(drawSourceRect: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 10), drawFillColor: .green, drawBorderWidth: 1)
        self.contentView.addSubview(tuberView)
        tuberView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.contentView.snp.top)
            make.height.equalTo(10)
            make.width.equalTo(self.bounds.width)
        }
        return tuberView
    }()
    
    // 初始化UI
    override func setupUI() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        // 不可点击,点击事件由cell完成
        itemIcon.isUserInteractionEnabled = false;
        itemContent.textAlignment = .center
        
        contentView.addSubview(itemIcon)
        contentView.addSubview(itemContent)
        
        // layout
        itemIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            
            // 默认不给size，需要UI给好图的尺寸
//            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.top.equalTo(tabbarConfiguration.iconTopInteval)
        }
        
        itemContent.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(itemIcon.snp.bottom).offset(tabbarConfiguration.spacingBetweenImageAndTitle)
        }
    }
    
    // 渲染模型
    func rendModel(_ itemModel: HTTabbarViewControllerItemModel) {
        model = itemModel
        var imageName = ""
        if itemModel.selected {
            imageName = itemModel.selectedImageName
            self.itemContent.textColor = tabbarConfiguration.selectedColor
            self.itemContent.font = tabbarConfiguration.selectedFont
        }else {
            imageName = itemModel.normalImageName
            self.itemContent.textColor = tabbarConfiguration.normalClor
            self.itemContent.font = tabbarConfiguration.normalFont
        }
        
        // 如果包含网页
        if  imageName.contains("http") {
            self.itemIcon.kf.setImage(with: URL.init(string: imageName))
        }else {
            let image = UIImage(named: imageName)
            self.itemIcon.image = image
        }

        
        // 如果没有内容，纯图标tabbarItem，得重新布局
        if itemModel.itemContent.isEmpty {
            // layout
               itemIcon.snp.remakeConstraints { (make) in
                   make.center.equalTo(self)
               }
                
            itemContent.snp_removeConstraints()
        }else {
                self.itemContent.text = itemModel.itemContent
        }

        // 显示border
        if tabbarConfiguration.showTabbarLine && !itemModel.isTuber {
//            self.contentView.qmui_borderColor = rgba(151, 151, 151, 0.4)
//            self.contentView.qmui_borderLocation = .outside
//            self.contentView.qmui_borderPosition = .top
//            self.contentView.qmui_borderWidth = 1
        }else if itemModel.isTuber {
            tuberView.isHidden = false
        }
        
    }
    
    // 播放动画
    func playAnimationIcon(_ iconNames: [String]) {
        // 如果为没有图片名称，那么就不执行
        guard iconNames.count == 0 else {
            return
        }
        
        
        var iconImages = [Image]()
        for i in 0...12 {
            iconImages.append(Image.name(iconNames[i]))
        }
        
        itemIcon.animationImages = iconImages  // 装图片的数组(需要做动画的图片数组)
        itemIcon.animationDuration = 2        // 动画时间
        itemIcon.animationRepeatCount = 1     // 重复次数 0 表示重复
        itemIcon.startAnimating()             // 开始序列帧动画
    }
    

}

struct HTTabbarViewControllerItemModel: Equatable {
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
    
    static func == (lhs: HTTabbarViewControllerItemModel, rhs: HTTabbarViewControllerItemModel) -> Bool {
           return lhs.normalImageName == rhs.normalImageName
       }
}

// viewModel,准备数据源，和相关网络请求等
class HTTabbarViewControllerViewModel {
    var sourceData = [HTTabbarViewControllerItemModel]()
    //    var items = [HTTabbarViewControllerItemModel]()
    var items = Observable.just([
        HTTabbarViewControllerItemModel()
    ])
}

extension DispatchQueue {
    private static var _onceToken = [String]()
    
    class func once(token: String = "\(#file):\(#function):\(#line)", block: ()->Void) {
        objc_sync_enter(self)
        
        defer
        {
            objc_sync_exit(self)
        }
        
        if _onceToken.contains(token)
        {
            return
        }
        
        _onceToken.append(token)
        block()
    }
}

// 自定义tabbar导航栏高度, 49感觉有点矮
let HTDefalutBarHeight: CGFloat = 53

// tabbar的总高度
let HTTabbarHeight = HaveSafeArea ? HTDefalutBarHeight + 34 : HTDefalutBarHeight


// 点击代理
protocol  HTTabbarViewControllerDelegate{
    func itemDidSelected(index: Int)
    func canChangePage(index: Int) -> Bool
}

extension HTTabbarViewControllerDelegate{

}

// tabbar的配置
struct HTTabbarConfiguration {
    // 原数据
    var sourceData = [HTTabbarViewControllerItemModel]()
 
    // rx相关包装过后的数据
      var items = Observable.just([
          HTTabbarViewControllerItemModel()
      ])
     
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
    var showTabbarLine: Bool = true
    
    // tabbar分割线颜色
       var segementLineColor: UIColor = rgba(151, 151, 151, 0.4)
}

// 外层只是个容器，包裹着bar,这样bar可以动态调整位置
class HTTabbar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 分割线
//    lazy var segementLine: UIView = {
//        var line = UIView()
//        line.backgroundColor = rgba(151, 151, 151, 0.4)
//        self.addSubview(line)
//        line.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(0)
//            make.height.equalTo(0.5)
//        }
//        return line
//    }()
    
    
    // 自定义导航栏
       lazy var bar: HTCollectionView = {
          let flowLayout = UICollectionViewFlowLayout.init()
                 flowLayout.scrollDirection = .horizontal
        
            let width: Int = Int(SCREEN_WIDTH / CGFloat(tabbarConfiguration.sourceData.count))
        
        
          print("宽度是\(width)")
        flowLayout.itemSize = CGSize.init(width:CGFloat(width) , height: HTDefalutBarHeight + tabbarConfiguration.iconTopInteval - 1)
                 var bar = HTCollectionView.init(classNames: ["HTTabbarItem"], flowLayout: flowLayout)
                 bar.isScrollEnabled = false
                self.addSubview(bar)
                bar.snp.makeConstraints { (make) in
                    make.left.right.equalTo(0)
                    
                    // 如果展示line
//                    if tabbarConfiguration.showTabbarLine {
//                        make.top.equalTo(self.segementLine.snp.bottom)
//                    }else {
//                        make.top.equalTo(0)
//                    }
                     make.top.equalTo(0)
                    make.height.equalTo(HTDefalutBarHeight + tabbarConfiguration.iconTopInteval)
                }
        
        bar.clipsToBounds = false
        bar.layer.masksToBounds = false
        
//        self.clipsToBounds = false
//               self.layer.masksToBounds = false
            return bar
    }()
    
    
    // 获取点击的cell
    func fetchItemWithIndex(index: Int) ->  HTTabbarItem{
        return bar.cellForItem(at: IndexPath(row: index, section: 0)) as! HTTabbarItem
    }

}


// tabbar.显示和隐藏信号,true是显示,false是隐藏
var tabbarShowOrHiddenSignal = PublishSubject<Bool>()


// 直接拿到底部
func baseTabbar() -> HTTabbar? {
    if  let tabbarViewController = topTabbarVC() {
        return tabbarViewController.htTabbar
    }
    return nil
}

//classNames:[String]
class HTTabbarViewController: UITabBarController,HTTabbarViewControllerDelegate {
    
    // 自定义导航栏
    var htTabbar = HTTabbar()
    
    // vm数据源
    let vm = HTTabbarViewControllerViewModel()
        
    // 模型数据
    init(itemModels:[HTTabbarViewControllerItemModel]) {
        tabbarConfiguration.sourceData = itemModels
        
        //        vm.items = itemModels
        vm.sourceData = itemModels
        vm.items = Observable.just(itemModels)
        super.init(nibName: nil, bundle: nil)
        
        
        // 显示或隐藏tabbar
        tabbarShowOrHiddenSignal.subscribe(onNext: { [weak self] (value) in
            print(value)
            self?.htTabbar.isHidden = !value
        }).disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 移除之前的导航栏
        self.tabBar.isHidden = true
        self.tabBar.removeFromSuperview()
        
        setupTabbar()
        
        //        DispatchQueue.once(token: "identify") {
        //            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: .main) { (notifi) in

        //            }
        //        }
        
    }
    
    // 上次点击的按钮模型
    var lastClickItemModel: HTTabbarViewControllerItemModel?
    
    // 上次点击的时间
    var lastClickTime: UInt64 = 0
    
    
    
    
//    // 用于统计时间
//    double MachTimeToSecs(uint64_t time)
//    {
//        mach_timebase_info_data_t timebase;
//        mach_timebase_info(&timebase);
//        return (double)time * (double)timebase.numer / (double)timebase.denom / 1e9;
//    }
    
    // 设置tabbar
    func setupTabbar() {
        self.view.addSubview(htTabbar)
        htTabbar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(HTTabbarHeight)
        }
        
        // rx绑定数据源,直接显示
        vm.items.bind(to: htTabbar.bar.rx.items(cellIdentifier: "HTTabbarItem", cellType: HTTabbarItem.self)) { [weak self] (collectionView, itemModel, cell) in
            cell.rendModel(itemModel)
            if itemModel.selected {
                self!.lastClickItemModel = itemModel
            }
        }
        .disposed(by: rx.disposeBag)
        
        // UInt64 转秒数
        func MachTimeToSecs(time: UInt64) -> Double {
            var  timebase = mach_timebase_info_data_t()
            mach_timebase_info(&timebase)
            
            return Double(time) * Double(timebase.numer) / Double(timebase.denom) / 1e9;
        }
        
        //  获取点击行
        htTabbar.bar.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            
            // 如果可以选中，那么选中
            if self?.canChangePage(index: indexPath.row) == true {
              
                
                // 点击的是同一个，就返回,检测是否双击
              var itemModel = self!.vm.sourceData[indexPath.row]
                if itemModel == self?.lastClickItemModel {
                  
                    // 当前时间
                    let currentTime: UInt64 = mach_absolute_time()
                    
                    // 如果时间小于0.5秒，0.5秒是最早windows双击的缺省值参考，可以调整
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
                      
//                         let lastIndex = 0
//                    self!.vm.sourceData.firstIndex(where:{$0 == self?.lastClickItemModel})
                    
                    
                    if let lastIndex = self!.vm.sourceData.firstIndex(where: { item -> Bool in
                        
                        print("\(item.normalImageName)")
                               return item == self!.lastClickItemModel
                       }){
                        
                        
                           let lastCell = self!.htTabbar.bar.cellForItem(at: IndexPath(row: lastIndex, section: 0)) as! HTTabbarItem
                            lastCell.rendModel(self!.lastClickItemModel!)
                       }
                    
                    
                }
                
                
                let cell = self!.htTabbar.bar.cellForItem(at: indexPath) as! HTTabbarItem
            
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
        
        self.view.layoutIfNeeded()
    }
    
    
    // 选择某个下标
    func itemDidSelected(index: Int) {
        
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
