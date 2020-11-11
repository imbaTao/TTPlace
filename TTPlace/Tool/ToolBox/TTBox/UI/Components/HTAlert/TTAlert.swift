//
//  TTAlert.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/5.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import SnapKitExtend


// 点击隐藏视图
class TTTouchHiddenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let tap = UITapGestureRecognizer.init()
        self.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { [weak self] ( _ ) in
            // 点击隐藏
            self?.isHidden = true
            self?.removeAllSubviews()
            self?.removeFromSuperview()
        }).disposed(by: rx.disposeBag)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 如果需要点击其他区域进行隐藏或者改样式，就继承TTTouchHiddenView
class TTAlert: UIView {
    // 背板视图
    var backgroudView = UIView()
    
    // 内容主视图,默认装一个UITextView
    var contentView = UIView()
    
    // 标题
    var titleLable = UILabel.regular(size: 15, textColor: .black)
    
    // 内容
    var mainContentTextView = YYTextView.init()
    
    // 按钮承载面板
    var buttonBoardView = UIView()
    
    
    // 默认最小尺寸
    var defalultMinSize = htSize(270, 130)
    
    // 默认最大尺寸
    var defalultMaxSize = htSize(270, 530)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.mainContentTextView.setContentOffset(.zero, animated: false)
    }
    
    
    //  创建时传入标题，内容，标题
    @discardableResult
    class func show(maxSize: CGSize,title: String,message: String,buttonTitles: [String], click:@escaping (_ index: Int)->()) -> TTAlert {
        
        let alert = TTAlert()
        alert.settingCornerRadius(20)
        
        alert.backgroudView.isUserInteractionEnabled = true
        alert.backgroudView.backgroundColor = .white
        
        // 如果为0那就自适应大小
        if maxSize == .zero {
//            alert.backgroudView = UIImageView.fetchImageViewContainerViewWithRadius(radius: 15, color: .white, size: CGSize.init(width: SCREEN_H, height: SCREEN_H))
        }else {
//            alert.backgroudView = UIImageView.fetchImageViewContainerViewWithRadius(radius: 15, color: .white, size: maxSize)
        }
//
//       alert.backgroudView.alignment = .center
//       alert.backgroudView.axis = .vertical
//       alert.backgroudView.spacing = ver(0)
//        alert.backgroudView.distribution = .fillProportionally
    

        // 添加边框
        alert.contentView.addBorderWithPositon(direction: .bottom, color: segementColor, height: 1)
        alert.contentView.backgroundColor = .red
//        alert.contentView.alignment = .center
//        alert.contentView.axis = .vertical
//        alert.contentView.spacing = ver(10)


        alert.titleLable.setContentHuggingPriority(.required, for: .vertical)
        alert.titleLable.text = title
        alert.titleLable.textAlignment = .center
        

        alert.mainContentTextView.text = message
        alert.mainContentTextView.textColor = .black
        alert.mainContentTextView.textAlignment = .center
        alert.mainContentTextView.isEditable = false
        alert.mainContentTextView.contentInset = .zero
//        alert.mainContentTextView.contentOffset = .zero
        alert.mainContentTextView.textVerticalAlignment = .top
        alert.mainContentTextView.textContainerInset = .zero
        

//        // 添加视图
        alert.addSubview(alert.backgroudView)
        alert.backgroudView.addSubview(alert.titleLable)
        alert.backgroudView.addSubview(alert.mainContentTextView)
//        alert.backgroudView.addArrangedSubview(alert.contentView)
        alert.backgroudView.addSubview(alert.buttonBoardView)
    

        // layout
        alert.backgroudView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()

            // 如果是自适应,那就自动撑开
            if maxSize.equalTo(.zero) {
                // 计算高度
                let layout = YYTextLayout(containerSize: CGSize(width: alert.defalultMinSize.width, height: CGFloat.greatestFiniteMagnitude), text: NSAttributedString.init(string: message))
                if let textHeight = layout?.textBoundingSize.height {
                    if textHeight <= alert.defalultMinSize.height {
                         make.size.equalTo(alert.defalultMinSize)
                    }else if textHeight > alert.defalultMaxSize.height {
                        make.size.equalTo(alert.defalultMaxSize)
                    }else {
                        
                        
                        //  计算高度
                        var height: CGFloat = 0.0
                        
                        
                        print("\(textHeight)")
                        
                        // 标题高度
                       let  titleLableHeight = alert.titleLable.sizeThatFits(CGSize.init(width: alert.defalultMinSize.width, height: CGFloat.greatestFiniteMagnitude)).height
                        height += titleLableHeight;
                        height  += 8.0 * 3 + textHeight +  44
                        print("高度 \(height)")
                        let autoSize = CGSize(width: alert.defalultMinSize.width, height: height)
                        make.size.equalTo(autoSize)
                    }
                }
            }else {
                make.size.equalTo(maxSize)
            }
        }

//        alert.contentView.snp.makeConstraints { (make) in
//            make.top.left.right.equalTo(0)
//            make.bottom.equalTo(alert.buttonBoardView.snp.top)
//        }

        
    
        alert.buttonBoardView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
       
        alert.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.width.equalToSuperview()
        }
        
        alert.mainContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(alert.titleLable.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.bottom.equalTo(alert.buttonBoardView.snp.top)
        }
        
        var buttonArray = [UIButton]()
        
        // 创建按钮
        for index in 0..<buttonTitles.count {
            // 标题
            let buttonTitle =  buttonTitles[index]


            // 按钮button
            let actionButton = UIButton.title(title: buttonTitle , titleColor: alertButtonColor, font: .regular(13))
            actionButton.setBackgroundImage(UIImage.init(color: #colorLiteral(red: 0.7411764706, green: 0.7450980392, blue: 0.7411764706, alpha: 1),size: htSize(414)), for: .highlighted)
            alert.buttonBoardView.addSubview(actionButton)
            


            // 多个按钮，设置右侧border
            if buttonTitles.count > 1 && index != buttonTitles.count - 1 {
                actionButton.addBorderWithPositon(direction: .right, color: segementColor, height: 0.5)
            }
            
            // 顶部border
            actionButton.addBorderWithPositon(direction: .top, color: segementColor, height: 0.5)

            // 按钮点击事件
            actionButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{(_) in
                click(index)
                self.hiddenAction(alert: alert)
            }).disposed(by: alert.rx.disposeBag)
            
            
            
//             按钮点击事件
//              actionButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{(_) in
//                  click(index)
//                  self.hiddenAction(alert: alert)
//              }).disposed(by: alert.rx.disposeBag)

            alert.buttonBoardView.addSubview(actionButton)
            
            
            
            buttonArray.append(actionButton)
            // 布局
            buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
            buttonArray.snp.makeConstraints { (make) in
                make.height.equalToSuperview()
            }
        }
        
        
        alert.backgroudView.settingCornerRadius(20)
        rootWindow().addSubview(alert)
        alert.backgroundColor = .gray
        alert.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return alert
    }
    
    // 隐藏操作
    class func hiddenAction(alert: TTAlert) {
        alert.isHidden = true
        alert.removeAllSubviews()
        alert.removeFromSuperview()
    }
    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {

        
        let lableSize  = self.titleLable
        print("尺寸为\(lableSize)")
        
        return super.sizeThatFits(size)
    }
}






extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

// 默认分割线颜色
var segementColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)

// 默认系统弹框按钮颜色
var alertButtonColor =  #colorLiteral(red: 0.01176470588, green: 0.4784313725, blue: 1, alpha: 1)


enum TTViewBorderDirection {
    case top
    case left
    case bottom
    case right
}

extension UIView {
    
    // 这个是简单的内边框,外边框还没实现
    func addBorderWithPositon(direction: TTViewBorderDirection,color: UIColor,height: CGFloat) {
        let mborderView = UIView.init()
        mborderView.backgroundColor = color
        
        self.addSubview(mborderView)
        
        
        switch direction {
        case .top:
            mborderView.snp.makeConstraints { (make) in
                make.top.left.right.equalTo(0)
                make.height.equalTo(height)
            }
        case .left:
            mborderView.snp.makeConstraints { (make) in
                make.top.bottom.left.equalTo(0)
                make.width.equalTo(height)
            }
        case .bottom:
            mborderView.snp.makeConstraints { (make) in
                make.bottom.left.right.equalTo(0)
                make.height.equalTo(height)
            }
        case .right:
            mborderView.snp.makeConstraints { (make) in
                make.top.bottom.right.equalTo(0)
                make.width.equalTo(height)
            }
        }
    }
}


// 全局显示原生的弹框
func showOriginalAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style,buttonTitles: [String],click: @escaping (_  index: Int)->()) {
    let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
    
    
    // 创建action
    for index in 0..<buttonTitles.count {
        // 标题
        let title =  buttonTitles[index]
        let action = UIAlertAction.init(title: title, style: .default) { (action) in
            click(index)
        }
        
        alertVC.addAction(action)
    }
    
    
    
    // 显示
    rootWindow().rootViewController?.present(alertVC, animated: true, completion: {
        
    })
}
