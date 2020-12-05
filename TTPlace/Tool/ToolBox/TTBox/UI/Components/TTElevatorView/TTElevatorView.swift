//
//  TTElevatorView.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/5.
//

import Foundation

// 点点击升降视图
class TTElevatorView<T: UIView>: UIControl {
    
    // 是否在执行动画
    var animating: Bool = false
    
    // 背后蒙版
    lazy var blackMaskView: UIControl = {
        var blackMaskView = UIControl()
        blackMaskView.backgroundColor = rgba(0, 0, 0, 0.2)
        addSubview(blackMaskView)
        blackMaskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return blackMaskView
    }()
    
    // 内容视图
//    lazy var contentContainer: UIStackView = {
//        var contentContainer =  UIStackView()
//        contentContainer.axis = .vertical
//        contentContainer.distribution = .fill
//
//
//        blackMaskView.addSubview(contentContainer)
//        contentContainer.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.bottom.equalTo(blackMaskView.snp.bottom)
//        }
//        return contentContainer
//    }()
    
    var contentView: T!
    
    // 动画时间
    var animateInterval = 0.4

    // 内容视图高度
    var contentViewHeight: CGFloat = 200
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        // layout
      
        
        
        // action
    }
    
    
    // 展示，内容视图根据block 在外面定义
    func creat(onWindow: Bool = true,parentView: UIView? = nil,contentView: T ,contentViewConfigBlock: @escaping (T) ->(),maskBackGroundColor: UIColor = rgba(0, 0, 0, 0.2),initShow: Bool = true,touchHidden: Bool = true) -> Self {
        blackMaskView.backgroundColor = maskBackGroundColor
        self.contentView = contentView
        contentViewConfigBlock(contentView)
        blackMaskView.addSubview(contentView)
        
        
        // 容器添加子内容
//        contentContainer.addArrangedSubview(contentView)
        
        // 获取到自定义视图的size，拿高度,重新布局
        blackMaskView.layoutIfNeeded()
        
        
        if contentView.size.height == 0 {
            assert(false, "用block或者提前在初始化的时候用snapkit定好size，只设置size不会蹦")
            
            // 例子实例
//            testView.snp.makeConstraints { (make) in
//                make.size.equalTo(ttSize(300, 200))
//            }
            
        }
        
        // 设置距离底部高度
        contentViewHeight = contentView.height
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(contentViewHeight)
        }
        

        // config
        if touchHidden {
 
            blackMaskView.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
                if self?.animating  == false {
                    // 可以点击隐藏的话，消失
                    self?.dismiss(complet: {
                        
                    })
                }
            }).disposed(by: rx.disposeBag)
        }

        
        // animate
        if initShow {
            showAnimate(onWindow: onWindow, parentView: parentView)
        }
        
        return self
    }
    
    
    //MARK: - 显示动画
    func showAnimate(onWindow: Bool = true,parentView: UIView? = nil) {
        if onWindow {
            rootWindow().addSubview(self)
            
        }else if parentView != nil {
            parentView!.addSubview(self)
        }
        
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // layout
        self.superview!.layoutIfNeeded()
        
        self.animating = true
        UIView.animate(withDuration: animateInterval) {
            
            self.contentView.snp.updateConstraints { (make) in
                make.bottom.equalTo(0)
            }
            
            self.superview!.layoutIfNeeded()
        }completion: { (_) in
            self.animating = false
        }
    }
    
    //MARK: - 隐藏动画
    func dismiss(complet:() -> ()) {
        self.animating = true
        UIView.animate(withDuration: animateInterval) {
            self.contentView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.contentView.height)
            }
            self.layoutIfNeeded()
        }completion: { (_) in
            self.removeSubviews()
            self.removeFromSuperview()
            self.animating = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
