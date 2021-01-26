//
//  TTAnimateView.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/25.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTAnimateView: Controll {
    enum TTAnimateViewState {
        case rise // 底部升起
        case down // 底部降下
        case centerShow // 中心显示
        case centerDismiss // 中心消失
    }
    
    enum TTAnimateViewType {
        case bottomRise // 底部升起
        case center // 中间弹框
    }
    
   private var animateState = TTAnimateViewState.rise
    {
        didSet {
            switch animateState {
            case .rise:
                
            case .down:
 
            default:break
            }
        }
    }
    
    // 动画的承载面板
    let contentView = SpringView()
    
    let stackView = StackView()
    override func makeUI() {
        super.makeUI()
        backgroundColor = rgba(0, 0, 0, 0.2)
        contentView.backgroundColor = .white
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        self.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            self.restoreAnimate()
        }).disposed(by: rx.disposeBag)
    }
    
    // 根据容器，添加动画视图
    func showAnimate(containerView: UIView? = UIApplication.shared.keyWindow,type: TTAnimateViewType)  {
        if containerView != nil {
            containerView!.addSubview(self)
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
          
            addSubview(stackView)
            stackView.addArrangedSubview(contentView)
            contentView.snp.makeConstraints { (make) in
//                make.left.top.equalToSuperview()
                make.edges.equalToSuperview()
            }
            
            
            
            switch type {
            case .bottomRise:
                stackView.snp.makeConstraints { (make) in
                    make.left.right.bottom.equalToSuperview()
                    make.height.greaterThanOrEqualTo(300)
                }
                animateState = .rise
            case .center:
                stackView.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                }
                animateState = .centerShow
            default:
                break
            }
            
        }else {
            assert(false, "父视图为ni，请检查父视图")
        }
    }
    
    
    // 还原动画
    func restoreAnimate() {
        switch animateState {
        case .rise:
            animateState = .down
        case .centerShow:
            animateState = .centerDismiss
        default:
            break
        }
    }
    
    // 内容视图添加子视图
    func addAnimteSubViews(_ views: [UIView]) {
        contentView.addSubviews(views)
    }
}
