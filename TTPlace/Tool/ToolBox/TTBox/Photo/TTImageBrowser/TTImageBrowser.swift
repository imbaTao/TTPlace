//
//  TTImageBrowser.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/13.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

// 图片缩放类
class TTPhotoZoomView: UIScrollView, UIScrollViewDelegate {
    var photoView = UIImageView()
    
    var imageNormalWidth: CGFloat = 0
    var imageNormalHeight: CGFloat = 0
    
    // 两侧边距
    var spaceValue: CGFloat = 0
    
    // 自动复原
    var restoreZoom = true
    
    var image: UIImage {
        set {
            photoView.image = newValue
            imageNormalWidth = newValue.size.width
            imageNormalHeight = newValue.size.height
        }get {
            return photoView.image ?? UIImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 3;
        self.delegate = self
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        
        
    
        photoView.contentMode = .scaleAspectFit
        photoView.isUserInteractionEnabled = true;
        
        
        
        let longGesture = UILongPressGestureRecognizer.init()
        longGesture.rx.event.subscribe(onNext: {[weak self] (_) in
            
            if let image = self?.photoView.image {
                
                
                showOriginalAlert(title: nil, message: nil, preferredStyle: .actionSheet, buttonTitles: ["保存图片到相册","取消"]) { (index) in
                    if index == 0 {
                        // 长按保存图片
                        self?.loadImage(image: image)
                    }
                }

            }
            
        }).disposed(by: rx.disposeBag)
        photoView.addGestureRecognizer(longGesture)
        
        
        
        addSubview(photoView)
        
        photoView.frame = CGRect.init(x: spaceValue, y: 0, width: SCREEN_W - spaceValue * 2, height: SCREEN_H)
//        photoView.snp.makeConstraints { (make) in
////            make.left.equalTo(0)
////            make.size.equalTo(htScreenSize())
//        }
//
        
        
        
        // 变更了图片,设置contentSize
        photoView.rx.observe(UIImageView.self, "image").subscribe {[weak self] (image) in
            
            
            
            if let photoSize = self?.photoView.image?.size {
//                self?.mainContent.contentSize = photoSize
            }
            
//            self?.mainContent.contentSize = (self?.photoView.image?.size)!
        }.disposed(by: rx.disposeBag)
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("开始缩放")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("结束缩放")
        
        // 如果自动还原
        if self.restoreZoom && scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        print("缩放中")
        
        
        print("\(scrollView.frame) 和 图片视图的位置 \(photoView.frame) 和图片视图的Bounds\(photoView.bounds)")
 
        
        let subView = scrollView.subviews[0]

        let offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)
            ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5
            : 0.0

        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)
            ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5
            : 0.0

        subView.center = CGPoint(
            x: scrollView.contentSize.width * 0.5 + offsetX,
            y: scrollView.contentSize.height * 0.5 + offsetY)
        
//        photoView.snp.updateConstraints { (make) in
//            make.left.equalTo((SCREEN_WIDTH - photoView.width) / 2)
//            make.top.equalTo((SCREEN_Height - photoView.height) / 2)
//        }
//
        
        
        
        
        
//    var imageViewFrame = photoView.frame
//     let width = imageViewFrame.size.width
//     let height = imageViewFrame.size.height
//     let sHeight = scrollView.bounds.size.height
//     let sWidth = scrollView.bounds.size.width
//     if height > sHeight {
//         imageViewFrame.origin.y = 0
//     } else {
//         imageViewFrame.origin.y = (sHeight - height) / 2.0
//     }
//     if width > sWidth {
//         imageViewFrame.origin.x = 0
//     } else {
//         imageViewFrame.origin.x = (sWidth - width) / 2.0
//     }
//     photoView.frame = imageViewFrame
    }
    
    
    //保存图片
       func loadImage(image:UIImage){
           UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
       }
       
       //回调
       @objc func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject)
       {
           if didFinishSavingWithError != nil
           {
               print("error!")
               return
           }
           
           print("保存成功")
       }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// 先不实现缩放，缩放功能再封装一个类
class TTImageBrowserPhotoCell:TTCollectionViewCell  {
    var zoomView = TTPhotoZoomView()
    
    override func setupUI() {
        addSubview(zoomView)
        zoomView.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.size.equalTo(htScreenSize())
        }
    }
}





class TTImageBrowserModel: NSObject {
    // 是否选中
    var selected = false
    
    // 下标
    var index = 0
    
    // 图片资源
    var image = UIImage()
}

extension TTCollectionView {
    func dequeueReusableCellWithDefaultIdentifer<T: UICollectionViewCell>(row: Int, class: T.Type) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        return self.dequeueReusableCell(withReuseIdentifier: self.classNames.first!, for: indexPath) as! T
    }
}

class TTImageBrowser<T>: BaseViewController,UINavigationControllerDelegate {
    
    // 动画管理者
    var animationManager = TTCutToAnimationManager()
    
    // 数据源
    var data = [TTImageBrowserModel]()
    
    // 是否自动复原
    var restoreZoom = false

    // 添加列表
    lazy var photoList: TTCollectionView = {
        var photoList = TTCollectionView.init(lineSpacing: 0, interitemSpacing: 0, classNames: ["TTImageBrowserPhotoCell"], derection: .horizontal)
       
        photoList.isPagingEnabled = true
        self.view.addSubview(photoList)
        photoList.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.size.equalTo(htScreenSize())
        }
        return photoList
    }()
    
    
    // 传入数据源,传入类型,传入当前下标,传入进来的视图
    init(sourceData: [UIImage],selectedIndex: Int,sourceView: UIView) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
        
        
        
        // 下标
        for index in 0..<sourceData.count {
            let image = sourceData[index]
            let model = TTImageBrowserModel()
            model.image = image
            model.index = index;
            // 设置选中
            if model.index == selectedIndex {
                model.selected = true
                
//                cutoEndView = UIImageView()
//                cutoEndView.backgroundColor = UIColor.init(patternImage: model.image)
//                cutoEndView.contentMode = .scaleAspectFit
//                cutoEndView.frame = CGRect.init(x: 0, y: NavigationBarHeight, width: SCREEN_W, height: SCREEN_H)
    
                
//                cutoEndView.frame = CGRect.init(x: 5, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            }
            
            self.data.append(model)
        }
        

        // 绑定
        Observable.just(data).bind(to: photoList.rx.items){[weak self](collectionView, row, element) in
            let cv = collectionView as! TTCollectionView
            let cell = cv.dequeueReusableCellWithDefaultIdentifer(row: row,class: TTImageBrowserPhotoCell.self)
            cell.zoomView.restoreZoom = self!.restoreZoom
            cell.zoomView.image = element.image
            
            
          
            return cell
        }.disposed(by: rx.disposeBag)
        
        photoList.reloadData()
        
        // 获取frame
//        view.layoutIfNeeded()
        
   
    }


    
    // 动画过渡
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        if operation == .push {
            animationManager.isPush = true
        }else {
            animationManager.isPush = false
            
            // 设置
           
            
            let indexPath = (self.photoList.indexPathsForVisibleItems.first)!
            
            print("当前下标是\(indexPath.row)")
            
            let cell = self.photoList.cellForItem(at: indexPath)! as! TTImageBrowserPhotoCell
            
            self.cutoStartView = cell.zoomView.photoView
        }
        
        
        
        return self.animationManager
    }
    
    
    //返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        
//        print("要返回了")
        return nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.delegate = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// 转场动画管理类
class TTCutToAnimationManager:NSObject,UIViewControllerAnimatedTransitioning {
    
    // 是否是push,pop状态
    var isPush = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPush {
            pushAnimation(transitionContext: transitionContext)
        }else {
            popAnimation(transitionContext: transitionContext)
        }
    }
    
    
    func pushAnimation(transitionContext: UIViewControllerContextTransitioning) {
        // 从哪个vc跳转过来的
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        
        // 去哪个控制器
//        let toVC = transitionContext.viewController(forKey: .to)
        
        
        //取出转场前后视图控制器上的视图view
//        let fromView = transitionContext .view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        // 容器视图，只有添加进容器的视图,才可以显示出来
        let container = transitionContext.containerView
        container.addSubview(toView!)
        
        
        // 执行动画位移的视图
//        let animationShootView = fromVC.cutoStartView.snapshotView(afterScreenUpdates: false)!
        
        
        
        let animationShootView = UIImageView.init(image: fromVC.cutoStartView.snapshotImage())
        
        // 如果是ImageView
        if ((fromVC.cutoStartView.isKind(of: UIImageView.self)) != nil) {
            let imageView = fromVC.cutoStartView as! UIImageView
            animationShootView.image = imageView.image
        }
        
        animationShootView.contentMode = .scaleAspectFit
        container.addSubview(animationShootView)
    
        
        // 起始位置与点击位置一致
        animationShootView.frame = CGRect.init(x: 0, y: fromVC.cutoStartView.origin.y + NavigationBarHeight, width: fromVC.cutoStartView.width, height: fromVC.cutoStartView.height)


        // 隐藏原视图
        fromVC.cutoStartView.isHidden = true
    
        
        // 隐藏到来的视图
        toView?.isHidden = true;
        
        //  执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut) {

            // 位移到结束点
            animationShootView.frame =  CGRect.init(x: 0, y: NavigationBarHeight, width: SCREEN_W, height: SCREEN_H)

        } completion: { (result) in
            
            // 隐藏截图视图
            animationShootView.isHidden = true
            
            
            // 显示即将显示的视图
            toView?.isHidden = false;
            
            // 显示视图
//            toVC?.cutoEndView.isHidden = false
            
            // 动画完成移除
            transitionContext.completeTransition(true)
        }
    }

    
    
    func popAnimation(transitionContext: UIViewControllerContextTransitioning) {
//        // 从哪个vc跳转过来的
        let fromVC = transitionContext.viewController(forKey: .from)!

        // 去哪个控制器
        let toVC = transitionContext.viewController(forKey: .to)!


        //取出转场前后视图控制器上的视图view
        let fromView = transitionContext .view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)

        // 容器视图，只有添加进容器的视图,才可以显示出来
        let container = transitionContext.containerView
//        container.addSubview(fromView!)
        container.addSubview(toView!)
        
//        toVC?.cutoStartView.isHidden = false

        
        
        fromVC.cutoStartView.backgroundColor = .clear
        
        // 截图视图
        let animationShootView = UIImageView.init(image: fromVC.cutoStartView.snapshotImage())
        
        // 如果是ImageView
        if (fromVC.cutoStartView.isKind(of: UIImageView.self)) {
            let imageView = fromVC.cutoStartView as! UIImageView
            animationShootView.image = imageView.image
        }
        animationShootView.backgroundColor = .clear
        
        animationShootView.contentMode = .scaleAspectFit
        container.addSubview(animationShootView)
    
        
        // 起始位置与点击位置一致
        animationShootView.frame = CGRect.init(x: 0, y: fromVC.cutoStartView.origin.y + NavigationBarHeight, width: fromVC.cutoStartView.width, height: fromVC.cutoStartView.height)


        // 隐藏原视图
//        fromVC.cutoStartView.isHidden = true
    
        
        // 隐藏要离开的视图
        fromVC.view.isHidden = true;
        
        //  执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut) {

            // 位移到结束点
            animationShootView.frame =  CGRect.init(x: 0, y: NavigationBarHeight + toVC.cutoStartView.origin.y, width: toVC.cutoStartView.width, height: toVC.cutoStartView.height)

        } completion: { (result) in
            
            // 隐藏截图视图
            animationShootView.isHidden = true
            
            // 显示即将显示的视图
            toView?.isHidden = false;
            
            // 显示视图
            toVC.cutoStartView.isHidden = false
            
            // 动画完成移除
            transitionContext.completeTransition(true)
        }
    }
}



extension UIViewController {
        
    // 关联属性添加转场动画启动view
       private struct TTCutToAnimationAssociatedKey {
            // tabbar 底部分割线
          static var cutoStartView: String = "cutoStartView"
        
          // 是否是tabbar控制器
          static var cutoEndView: String = "cutoEndView"
      }
      
      public var cutoStartView: UIView {
          get {
              return objc_getAssociatedObject(self, &TTCutToAnimationAssociatedKey.cutoStartView) as? UIView ?? UIView()
          }
          set {
              objc_setAssociatedObject(self, &TTCutToAnimationAssociatedKey.cutoStartView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
          }
      }
    
    // 是否是导航栏上的
    public var cutoEndView: UIView {
        get {
            return objc_getAssociatedObject(self, &TTCutToAnimationAssociatedKey.cutoEndView) as? UIView ?? UIView()
        }
        set {
            objc_setAssociatedObject(self, &TTCutToAnimationAssociatedKey.cutoEndView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
