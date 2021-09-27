//
//  TTMarqueeView.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/28.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

// 跑马灯
class TTMarqueeView: TTControll {
    let contentLabel = UILabel.regular(size: 14, textColor: .white, text: "", alignment: .left)
    
    // 速度
    let speed: CGFloat = 0.8
    
    // 步进
    let stepInstance: CGFloat = 2
    
    // 数据源
    var data = [TTMarqueeModel]()
    
    // 点击选中事件
    var selectedAction: ((TTMarqueeModel) -> ())?
    
    // 定时器回收袋
    var runDisposeBag = DisposeBag()
    var isRunning = false
    
    override func makeUI() {
        super.makeUI()
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(SCREEN_W)
        }
        
        layoutIfNeeded()
        
        // 背景色
        backgroundColor = .red
        self.isHidden = true
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        // 点击事件
        rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            if let currentModel = self.data.first {
                if currentModel.canSelection {
                    self.selectedAction?(currentModel)
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    // 开始运行
    func run() {
        if !isRunning {
            // 每秒移动
            TTTimer.shared.displayTimer.subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                // 如果右侧小于边界
                if self.contentLabel.frame.origin.x + self.contentLabel.width > 0 {
                    self.contentLabel.x -= self.speed * self.stepInstance
                }else {
                    self.checkNext()
                }
            }).disposed(by: runDisposeBag)
            
            
            isRunning = true
        }
    }
    
    // 停止运行
    func stop() {
        runDisposeBag = DisposeBag()
        // 隐藏自己,重置位置
        self.isHidden = true
        resetLabelPositon()
        isRunning = false
    }
    
    // 检测是否有下一个精灵
    func checkNext() {
        // 移除最后一个
        if let _ = data.first {
            data.removeFirst()
        }
        
        // 仍然有值,
        if let model = data.first {
            changeContent(model)
            if !isRunning {
                run()
            }
        }else {
            stop()
        }
    }
    
    // 添加内容模型
    func addContent(model: TTMarqueeModel) {
        data.append(model)
    }
    
    
    // 变更内容
    func changeContent(_ model: TTMarqueeModel) {
        switch model.type {
        case .normalText:
            contentLabel.text = model.textContent
        case .attributeText:
            contentLabel.attributedText = model.attributeContent
        }
        
        // 显示自己
        self.isHidden = false
        
        // 变更内容的时候run
        run()
    }
    
    // 重置label位置
    private func resetLabelPositon() {
        self.contentLabel.x = SCREEN_W
    }
}


extension TTMarqueeView {
    // 添加常规文本内容
    func addNormalContent(contents: [String]) {
        for item in contents {
            addContent(model: TTMarqueeModel.normalTextModel(text: item))
        }
        
        // 设置第一个为内容
        if let model = data.first {
            changeContent(model)
        }
    }
}


enum TTMarqueeModelType {
    case normalText
    case attributeText
}

class TTMarqueeModel: NSObject {
    
    // 纯文本
    var textContent: String = ""
    
    // 富文本
    var attributeContent: NSMutableAttributedString?

    let type: TTMarqueeModelType = .normalText

    // 可以点击
    var canSelection = false
    
    
    
    // 普通文本model
    class func normalTextModel(text: String) -> TTMarqueeModel {
        let model = TTMarqueeModel()
        model.textContent = text
        return model
    }
}




