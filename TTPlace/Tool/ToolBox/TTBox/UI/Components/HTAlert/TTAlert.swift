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
    var defalultMinSize = ttSize(260, 130)
    
    // 默认最大尺寸
    var defalultMaxSize = ttSize(260, 359)
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.mainContentTextView.setContentOffset(.zero, animated: false)
    }
    
    
    //  创建时传入标题，内容，标题
    @discardableResult
    class func show(maxSize: CGSize = .zero,title: String = "提示",titleFont: UIFont = .medium(16),titleTopInterval: CGFloat = ver(8),messageEdges: UIEdgeInsets = .zero,message: String = "",attributeMessage: NSMutableAttributedString? = nil,spaceBetweenTitleMessage: CGFloat = ver(18),buttonBoardHeight: CGFloat = ver(44),buttonTitles: [String] = ["确认","取消"],customButtons: [UIButton] = [UIButton](),cornerRadius: CGFloat = 20,maskBackGroundColor: UIColor = .gray, leadSpacing: CGFloat = 0, tailSpacing: CGFloat = 0, fixedSpacing: CGFloat = 0,click:@escaping (_ index: Int)->()) -> TTAlert {
        
        let alert = TTAlert()
        alert.settingCornerRadius(20)
        
        alert.backgroudView.isUserInteractionEnabled = true
        alert.backgroudView.backgroundColor = .white
        
        // 添加边框
        alert.contentView.addBorderWithPositon(direction: .bottom, color: segementColor, height: 1)
        alert.contentView.backgroundColor = .red
        
        
        alert.titleLable.setContentHuggingPriority(.required, for: .vertical)
        alert.titleLable.text = title
        alert.titleLable.textAlignment = .center
        alert.titleLable.font = titleFont
        
        
      
        // 如果消息不为空
        if attributeMessage != nil {
            if attributeMessage!.length > 0 {
                alert.mainContentTextView.attributedText = attributeMessage
            }
        }else {
            alert.mainContentTextView.text = message
        }
        
        
        
        alert.mainContentTextView.textColor = .black
        alert.mainContentTextView.textAlignment = .center
        alert.mainContentTextView.isEditable = false
        alert.mainContentTextView.contentInset = messageEdges
        alert.mainContentTextView.textVerticalAlignment = .top
        alert.mainContentTextView.textContainerInset = .zero
        alert.mainContentTextView.showsVerticalScrollIndicator = false
        
        
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
                
                // 计算用的最大宽度
                let messageContentWidth = alert.defalultMinSize.width - messageEdges.left - messageEdges.right
                

                // 计算高度
                let layout = YYTextLayout(containerSize: CGSize(width: messageContentWidth, height: CGFloat.greatestFiniteMagnitude), text: NSAttributedString.init(string: message.count > 0 ? message : attributeMessage!.string))
                
                
                // 标题高度
                let  titleLableHeight = alert.titleLable.sizeThatFits(CGSize.init(width: messageContentWidth, height: CGFloat.greatestFiniteMagnitude)).height
                
                // 默认控件的间距和自带的高度
                let defalutConponentsHeight = titleTopInterval + titleLableHeight + spaceBetweenTitleMessage + buttonBoardHeight
                
                if let textHeight = layout?.textBoundingSize.height {
                    
                    // 如果高度小于默认的最小高度，就默认
                    if textHeight + defalutConponentsHeight <= alert.defalultMinSize.height {
                        make.size.equalTo(alert.defalultMinSize)
                    }else if textHeight + defalutConponentsHeight > alert.defalultMaxSize.height {
                        
                        // 是否大于默认最大的高度
                        make.size.equalTo(alert.defalultMaxSize)
                    }else {
                        
                        
                        //  计算高度
//                        var height: CGFloat = 0.0
//
//
//                        print("\(textHeight)")
//
//
//                        height += titleLableHeight + ;
//                        height += defalutConponentsHeight
                        
//                        print("高度 \(height)")
                        let autoSize = CGSize(width: alert.defalultMinSize.width, height: textHeight + defalutConponentsHeight)
                        make.size.equalTo(autoSize)
                    }
                }
            }else {
                make.size.equalTo(maxSize)
            }
        }
        
        
        alert.buttonBoardView.snp.makeConstraints { (make) in
            make.height.equalTo(buttonBoardHeight)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        alert.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(titleTopInterval)
            make.width.equalToSuperview()
        }
        
        alert.mainContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(alert.titleLable.snp.bottom).offset(spaceBetweenTitleMessage)
            make.width.equalToSuperview()
            make.bottom.equalTo(alert.buttonBoardView.snp.top)
        }
        
        // 如果没有自定义按钮
        var buttonArray = [UIButton]()
        
        
        
        if customButtons.count == 0 {
            
            // 创建按钮
            for index in 0..<buttonTitles.count {
                // 标题
                let buttonTitle =  buttonTitles[index]
                
                
                // 按钮button
                let actionButton = UIButton.title(title: buttonTitle , titleColor: alertButtonColor, font: .regular(13))
                actionButton.setBackgroundImage(UIImage.init(color: #colorLiteral(red: 0.7411764706, green: 0.7450980392, blue: 0.7411764706, alpha: 1),size: ttSize(414)), for: .highlighted)
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
                
                
                
                alert.buttonBoardView.addSubview(actionButton)
                
                buttonArray.append(actionButton)
                // 布局
                buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
                buttonArray.snp.makeConstraints { (make) in
                    make.height.equalToSuperview()
                }
            }
        }else {
            
            // 按钮高度
            var buttonHeight: CGFloat = 0;
            
            // 创建按钮
            for index in 0..<customButtons.count {
                let customButton = customButtons[index]
                customButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{(_) in
                    click(index)
                    self.hiddenAction(alert: alert)
                }).disposed(by: alert.rx.disposeBag)
                
                alert.buttonBoardView.addSubview(customButton)
                buttonHeight = customButton.height
            }
            
            // 布局
            customButtons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: fixedSpacing, leadSpacing: leadSpacing, tailSpacing: tailSpacing)
            customButtons.snp.makeConstraints { (make) in
                make.height.equalTo(buttonHeight)
                make.bottom.equalTo(-ver(23))
            }
        }
        
        
        
        alert.backgroudView.settingCornerRadius(cornerRadius)
        rootWindow().addSubview(alert)
        alert.backgroundColor = maskBackGroundColor
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
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        
        let lableSize  = self.titleLable
        print("尺寸为\(lableSize)")
        
        return super.sizeThatFits(size)
    }
}



// 全局显示原生的弹框
func showOriginalAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style,buttonTitles: [String],click: @escaping (_  index: Int)->()) {
    let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
    
    
    // 创建action
    for index in 0..<buttonTitles.count {
        // 标题
        let title =  buttonTitles[index]
        
        
        var style = UIAlertAction.Style.default
        
        if title.contains("取消") {
            style = UIAlertAction.Style.cancel
        }
        
        let action = UIAlertAction.init(title: title, style: style) { (action) in
            click(index)
        }
        
        alertVC.addAction(action)
    }
    
    
    
    // 显示
    rootWindow().rootViewController?.present(alertVC, animated: true, completion: {
        
    })
}
