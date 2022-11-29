//
//  TTMarqueeView.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/28.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

enum TTMarqueeViewModul {
    case waitMaxWidth  // 等待达到最大宽度，再滚动
    case circle  // 循环模式
}

class TTMarqueeNode: UILabel {
    // 默认是有效的
    var isValid = true
}

// 跑马灯
class TTMarqueeView: TTControll {

    private let nodeFont: UIFont!
    private let nodeTextColor: UIColor!

    // 速度
    var speed: CGFloat = 0.8

    // 步进
    let stepInstance: CGFloat = 2

    // 数据源
    var nodes = [TTMarqueeNode]()

    // 点击选中事件
    var selectedAction: ((TTMarqueeModel) -> Void)?

    // 定时器回收袋
    var runDisposeBag = DisposeBag()
    var isRunning = false

    // 最大内容宽度
    var maxContentWidth: CGFloat = 100.0

    private var modul = TTMarqueeViewModul.circle

    init(modul: TTMarqueeViewModul = .circle, font: UIFont, textColor: UIColor) {
        self.modul = modul
        self.nodeFont = font
        self.nodeTextColor = textColor
        super.init(frame: .zero)

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()
        isHidden = true
    }

    override func bindViewModel() {
        super.bindViewModel()
        // 点击事件
        rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            //            if let currentModel = self.nodes.first {
            //                if currentModel.canSelection {
            //                    self.selectedAction?(currentModel)
            //                }
            //            }
        }).disposed(by: rx.disposeBag)
    }

    // 开始运行
    func run() {
        if !isRunning {
            guard nodes.isNotEmpty else {
                return
            }
            // 显示轮播
            isHidden = false

            // 每秒移动
            TTTimer.shared.displayTimer.subscribe(onNext: { [weak self] (_) in
                guard let self = self else { return }
                self.moveNode()
            }).disposed(by: runDisposeBag)

            isRunning = true
        }
    }

    // 移动每个节点
    private func moveNode() {
        for node in self.nodes {
            // 如果右侧小于边界.那么一直减x距离
            if node.frame.origin.x + node.width > 0 {
                node.x -= self.speed * self.stepInstance

                checkSroll()
            } else {
                // 超出边界了
                guard node.isValid else {
                    // 如果不可用了就移除
                    node.removeFromSuperview()
                    nodes.removeAll(node)
                    checkSroll()
                    return
                }

                // 能取到最后一个node,且不是当前node，就添加到末尾
                if let lastNode = self.nodes.last, lastNode != node {
                    // 移除当前的
                    nodes.removeAll(node)

                    // 添加到末尾去
                    nodes.append(node)

                    // 上一个的内容超过边界了，那就拼接在上一个的后面
                    if lastNode.x + lastNode.width > self.width {
                        node.x = lastNode.x + lastNode.width
                    } else {
                        // 否则拼接在末尾处
                        node.x = self.width
                    }
                } else {
                    // 取不到直接拼接到末尾
                    node.x = self.width
                }
            }
        }
    }

    // 检查是否继续滚动
    func checkSroll() {
        // 当有node被移除时，检查队列里有没有不可用的node,，轮询回来后，检查一下长度
        if modul == .waitMaxWidth {
            let unvaliableNodes = nodes.filter({ $0.isValid == false })

            // 即将移除的节点为空，那么检查文本长度是否需要停了
            if unvaliableNodes.isEmpty {
                if checkMaxWidthToNeedRun() {
                    run()
                } else {
                    stop()
                }
            }
        }
        return
    }

    // 添加节点
    func addNode(
        content: String, font: UIFont, textColor: UIColor, _ marqueBackgroundcolor: UIColor = .red,
        _ needRemoveBefore: Bool = false
    ) {
        let node = TTMarqueeNode()
        node.text = content
        node.font = font
        node.textColor = textColor
        backgroundColor = marqueBackgroundcolor

        // 移除所有之前节点
        if needRemoveBefore {
            removeAllContent()
        }

        // 添加节点到视图
        addSubview(node)

        // 找得到上一个
        if let lastNode = nodes.last {
            node.snp.makeConstraints { (make) in
                make.left.equalTo(lastNode.snp.right)
                make.top.bottom.equalToSuperview()
            }
        } else {
            node.snp.makeConstraints { (make) in
                make.left.equalTo(self.width)
                make.top.bottom.equalToSuperview().inset(3)
            }
        }

        // 添加节点到数据源
        nodes.append(node)
        switch self.modul {
        case .circle:
            run()
        case .waitMaxWidth:
            if checkMaxWidthToNeedRun() {
                run()
            } else {
                stop()
            }
        }
    }

    // 回原点位置
    func backToTheOrigin() {
        if let node = nodes.first {
            node.snp.remakeConstraints { (make) in
                make.left.equalTo(self.width)
                make.top.bottom.equalToSuperview().inset(3)
            }
        }
    }

    // 停止运行
    func stop() {
        runDisposeBag = DisposeBag()
        isRunning = false
    }
}

extension TTMarqueeView {
    // 移除当前这一轮的所有内容
    func removeAllContent() {
        nodes.forEach { (node) in
            node.isValid = false
        }

        isHidden = true
    }

    //    // 移除
    //    func removeNode(content: String) {
    //        if let node = nodes.removeFirst(where: { (node) -> Bool in
    //            return node.text == content
    //        }) {
    //         node.isValid = false
    //       }
    //    }
    //

    // 添加常规文本内容
    func addNormalContent(contents: [String]) {
        var lastNode = nodes.last
        for content in contents {

            let node = TTMarqueeNode.init(text: content)
            node.font = self.nodeFont
            node.textColor = self.nodeTextColor
            node.textAlignment = .left
            nodes.append(node)
            addSubview(node)

            // 找得到上一个
            if let lastNode = lastNode {
                node.snp.remakeConstraints { (make) in
                    make.left.equalTo(lastNode.snp.right)
                    make.top.bottom.equalToSuperview()
                }
            } else {
                node.snp.remakeConstraints { (make) in
                    make.left.equalTo(0)
                    make.top.bottom.equalToSuperview()
                }
            }

            // 记录上一个
            lastNode = node
        }

        switch self.modul {
        case .circle:
            break
        case .waitMaxWidth:
            if checkMaxWidthToNeedRun() {
                run()
            } else {
                //                stop()
            }
        default:
            break
        }
    }

    //  默认逗号隔开
    func updateContents(contents: [String], separator: String = "，") {
        self.nodes.removeAll { (node) -> Bool in
            node.removeFromSuperview()
            node.isHidden = true
            return true
        }

        //        var containsContent = [String]()
        //        // 剔除旧内容
        //        for node in self.nodes {
        //            if let text = node.text,contents.contains(text.nsString.replacingOccurrences(of: separator, with: "")) {
        //                // 包含
        //                debugPrint("包含跑马灯内容\(text)")
        //                containsContent.append(text)
        //            }else {
        //                // 不包含就移除旧的
        //                node.isValid = false
        //            }
        //        }

        let finalContens = contents.map { (content) -> String in
            // 不是最后一个，就内容添加分隔符
            if content != contents.last, content.count > 1 {
                return content + separator
            } else {
                return content
            }
        }

        if contents.isNotEmpty {
            // 添加不存在的新内容到末尾
            addNormalContent(contents: finalContens)
        }

        //        // 添加分隔符
        //        for node in self.nodes {
        //            // 是第一个节点,总数量大于1,且第一个节点不包含分隔符的话，让第一个节点添加分隔符
        //            if node != self.nodes.last {
        //                if let nodeText = node.text,nodeText.contains(separator as String) == false {
        //                    node.text?.append(separator as String)
        //                }
        //            }else {
        //                // 是最后一个,且唯一，移除最后一个分隔符
        //                if self.nodes.count == 1 {
        //                    node.text?.nsString.replacingOccurrences(of: separator, with: "")
        //                }
        //            }
        //        }
    }

    // 检测内容最大宽度
    func checkMaxWidthToNeedRun() -> Bool {
        var content = ""
        var needRun = false
        for node in nodes {
            // 叠加内容
            content += node.text ?? ""

            // 如果总内容大于最大宽度，那么滚动跑马灯
            if content.textWidth(font: node.font, height: node.height) > maxContentWidth {
                needRun = true
            }
        }
        return needRun
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
